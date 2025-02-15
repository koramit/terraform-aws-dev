variable "infra_env" {
  type        = string
  description = "infrastructure environment"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The IP range to use for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "AZs to create subnets into"
}

variable "public_subnets" {
  type        = list(string)
  description = "subnets to create for public network traffic, one per AZ"
}

variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "subnets to create for private network traffic, one per AZ"
}
