terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

locals {
  app_name = "rds-dbt-transformations"
}

provider "aws" {
  region = "eu-west-2"
}
