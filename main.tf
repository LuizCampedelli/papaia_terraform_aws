terraform {
  required_version = ">=1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.74.0"
    }
  }
  backend "s3" {
    bucket = "terraform-luiz-campedelli"
    key    = "terraform-state"
    region = "us-east-1"

  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      env     = "dev"
      projeto = "ada_terraform"
      dono    = "Luiz_Campedelli"
    }
  }
}
