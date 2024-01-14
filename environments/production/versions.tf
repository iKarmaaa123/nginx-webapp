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
    bucket = "devops-project-backend"
    key    = "dev_statefile/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

