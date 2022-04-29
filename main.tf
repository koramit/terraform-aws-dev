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

provider "aws" {
  profile = "nephrosi"
  region  = "ap-southeast-1"
}