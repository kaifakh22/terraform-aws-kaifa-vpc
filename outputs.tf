output "vpc_id" {
  description = "ID of the created VPC"
  value = aws_vpc.main.id
}


locals {
  #to format the subnet IDs which may be multiples in format of subnet_name = {id= , az=}, it will be a map
  public_subnet_output = {
    for key, config in local.public_subnet : key => {
      id = aws_subnet.subnet_name[key].id
      az = aws_subnet.subnet_name[key].availability_zone
    }
  }


 #to format the subnet IDs which may be multiples in format of subnet_name = {id= , az=}, it will be a map
  private_subnet_output = {
    for key, config in local.private_subnet : key => {
      id = aws_subnet.subnet_name[key].id
      az = aws_subnet.subnet_name[key].availability_zone
    }
  }

}



output "public_subnets" {
  description = "List of public subnet IDs"
  value = local.public_subnet_output
  
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value = local.private_subnet_output
  
}