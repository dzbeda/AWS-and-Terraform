variable "vpc_cidr" {
  type = string
  default = ""
}
## VPC
resource "aws_vpc" "vpc-main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags       = {
    Name = "main"
    env = var.tags_env
  }
}

## Internet GW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc-main.id
  tags = {
    Name = "main"
    env = var.tags_env
  }
}