variable "vpc_config" {
  description = "User Input CIDR block for the VPC"
  type        = object({
    name = string
    cidr_block = string 
  })
  validation {
    condition     = can(regex("^(\\d{1,3}\\.){3}\\d{1,3}\\/\\d{1,2}$", var.vpc_config.cidr_block))
    error_message = "The CIDR block must be in the format x.x.x.x/x "
  }
}

variable "subnet_config" {
  description = "User Input CIDR block for the Subnet"
  # sub1={cidr_block="", az=""} sub2={cidr_block="", az=""}
  type        = map(object({
    cidr_block = string 
    az         = string
    public     = optional(bool, false) #optional key with default value false 
  }))

  validation {
    #Use alltrue to ensure all map values pass the condition.
    #alltrue([true, true, true])    # returns true
#alltrue([true, false, true])   # returns false

    #condition = alltrue([for config in var.subnet_config : can(cidernetmask(config.cidr_block))])
    condition = alltrue([for config in var.subnet_config : can(regex("^(\\d{1,3}\\.){3}\\d{1,3}\\/\\d{1,2}$",config.cidr_block))])
    error_message = "value must be in the format x.x.x.x/x"
  }
  
}