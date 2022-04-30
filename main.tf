## Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-backend-nephrosi"
    key            = "development/terraform.tfstate"
    profile        = "nephrosi"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-backend-nephrosi-development"
  }
}

## aws config
provider "aws" {
  profile = "nephrosi"
  region  = "ap-southeast-1"
}

## VPC
module "vpc" {
  source          = "./modules/vpc"
  infra_env       = var.infra_env
  vpc_cidr        = "10.0.0.0/17"
  azs             = var.default_azs
  public_subnets  = slice(cidrsubnets("10.0.0.0/17", 2, 2, 2), 0, 3)
  private_subnets = []
}
