variable "region" {
  default = "ap-northeast-1"
}

variable "vpc-range" {
  default = "10.0.0.0/16"
}

variable "public-subnets" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private-subnets" {
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

locals {
  product_name = "sandbox"
}
