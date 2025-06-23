provider "aws" {
    region = "ap-south-1"
    profile = "tf-user"
}



module "vpc" {
    source = "./module/vpc"
    vpc_config = {
        name       = "module-vpc"
        cidr_block = "10.0.0.0/16"
    }

    subnet_config = {
      #key = {cidr_block="", az=""}
      private_subnet ={
        cidr_block = "10.0.0.0/24"
        az = "ap-south-1a"
      }

  
      public_subnet-1 = {
        cidr_block = "10.0.1.0/24"
        az = "ap-south-1b"
        public = true #optional key with default value false
    }

    public_subnet-2 = {
        cidr_block = "10.0.2.0/24"
        az = "ap-south-1b"
        public = true #optional key with default value false
    }
}

}

