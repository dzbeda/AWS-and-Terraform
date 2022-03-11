resource "aws_security_group" "ec2-public" {
  name ="ec2-public-security-group"
  vpc_id = aws_vpc.vpc-main.id
  ## Incoming roles
  ingress {
    from_port = 22
    to_port =  22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "main"
    env = var.tags_env
  }
}

resource "aws_security_group" "ec2-private" {
  name ="ec2-private-security-group"
  vpc_id = aws_vpc.vpc-main.id
  ## Incoming roles
  ingress {
    from_port = 22
    to_port =  22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "main"
    env = var.tags_env
  }
}

resource "aws_security_group" "alb" {
  name ="alb-security-group"
  vpc_id = aws_vpc.vpc-main.id
  ## Incoming roles
  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "main"
    env = var.tags_env
  }
}