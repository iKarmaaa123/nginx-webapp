terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "nginx-backend-project"
    key    = "stag_statefile/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

