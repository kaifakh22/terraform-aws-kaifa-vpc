# Terraform Custom VPC Module

This module creates a customizable AWS VPC along with subnets using Terraform.

## Features

- Creates a VPC with a user-defined CIDR block and name.
- Creates multiple subnets (public/private) with user-defined CIDR blocks and availability zones.
- Tags resources for easy identification in the AWS Console.

## Usage

```hcl
module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    name       = "custom-vpc"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    public1 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
      #to set the subnet as public
      public     = true
    }
    private1 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
      public     = false
    }
  }
}
```

## Input Variables

| Name          | Type   | Description                                 | Example                |
|---------------|--------|---------------------------------------------|------------------------|
| vpc_config    | object | VPC configuration (name, cidr_block)        | `{ name = "...", cidr_block = "..." }` |
| subnet_config | map    | Map of subnet configs (cidr_block, az, public) | See usage above        |

## Outputs

You can add outputs as needed, such as VPC ID, subnet IDs, etc.

## Example

See the [main.tf](main.tf) file for a complete example.

---

**Note:**  
- The `Name` tag is used for AWS Console display.
- Make sure to provide valid CIDR blocks and availability zones.