resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block
  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "subnet_name" {
  for_each = var.subnet_config #key={cidr,az} each.key each.value
  vpc_id   = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az
  
  tags = {
    Name = "${var.vpc_config.name}-${each.key}"
  }

}

locals {
  public_subnet = { #this will be a maop of public subnets
    for key, value in var.subnet_config : key => value if value.public == true
  }

  private_subnet = { #this will be a maop of private subnets
    for key, value in var.subnet_config : key => value if value.public == false
  }
}


#create if there is at least one public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0 #if there is at least one public subnet then create ig
  tags = {
    Name = "${var.vpc_config.name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0 #if there is at least one public subnet then create route table.. here count is used so the public will be listed as a list
  tags = {
    Name = "${var.vpc_config.name}-public-rt"
  }

  route {
    cidr_block = "0.0.0.0/0" #This is destination for all traffic
    gateway_id = aws_internet_gateway.igw[0].id #target is the internet gateway
  }
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnet
  subnet_id = aws_subnet.subnet_name[each.key].id #each.key will be the name of the subnet where the public is true..
  # private_subnet ={
      #  cidr_block = "10.0.0.0/24"
       # az = "ap-south-1a"
     # } in this each.key will be private_subnet
  route_table_id = aws_route_table.public[0].id
}