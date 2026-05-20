
terraform {

  required_version = ">= 0.14.10"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }

  }

}

# Configure the AWS Provider
provider "aws" {
  region  = "ap-southeast-2"
  profile = "hoc-terraform-sso"
}
