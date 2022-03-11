variable "public-subnet-block" {
  type = list(string)
}
variable "private-subnet-block" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}
resource "aws_subnet" "public_subnet" {
  count = 2
  cidr_block = var.public-subnet-block[count.index]
  availability_zone = var.availability_zone[count.index]
  vpc_id = aws_vpc.vpc-main.id
  map_public_ip_on_launch = true
  tags = {
    Name = "public-main-${count.index+1}"
    env = var.tags_env
  }
}

resource "aws_subnet" "private_subnet" {
  count = 2
  cidr_block = var.private-subnet-block[count.index]
  availability_zone = var.availability_zone[count.index]
  vpc_id = aws_vpc.vpc-main.id
  map_public_ip_on_launch = false
  tags = {
    Name = "private-main-${count.index+1}"
    env = var.tags_env
  }
}