resource "aws_security_group" "nginx-server" {
  name = "nginx-security-group"
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
}