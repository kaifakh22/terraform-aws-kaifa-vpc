 Example: Complete Custom VPC Module Usage

This example demonstrates how to use the custom VPC Terraform module to provision a complete VPC setup in AWS.

## Usage

```hcl
module "vpc" {
  source = "../../module/vpc"

  # Example input variables
  vpc_name           = "example-vpc"
  cidr_block         = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  enable_nat_gateway   = true

  # Add other variables as required by the module
}
```

## Inputs

Refer to the [variables.tf](../../module/vpc/variables.tf) file for a full list of input variables and their descriptions.

## Outputs

Refer to the [outputs.tf](../../module/vpc/outputs.tf) file for a full list of outputs exported by the module.

## How to Run

1. Initialize Terraform:
   ```sh
   terraform init
   ```

2. Review the plan:
   ```sh
   terraform plan
   ```

3. Apply the configuration:
   ```sh
   terraform apply
   ```

## Notes

- Ensure your AWS credentials are configured.
- Adjust variable values as needed for your environment.

---

For more details, see the main [README.md](../../module/vpc/README.md) of the module.