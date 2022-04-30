module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "nephrosi-${var.infra_env}-vpc"
  cidr = var.vpc_cidr

  azs = var.azs

  # No NAT gateway
  enable_nat_gateway = false

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = {
    Name        = "nephrosi-${var.infra_env}-vpc"
    Project     = "nephrosi.org"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}
