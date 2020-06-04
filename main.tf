terraform {
  required_version = ">= 0.12.26"
  backend "s3" {
    bucket = "mnenm-home-depot"
    region = "ap-northeast-1"
    key    = "sandbox.tfstate"
  }
}

provider "aws" {
  region = local.region
}

data "aws_caller_identity" "my" {}
