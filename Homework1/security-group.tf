resource "aws_security_group" "nginx-server" {
  name = "nginx-security-group"
  ## Incoming roles
  ingress {
    from_port = 22
    to_port =  22
    protocol = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol  = "http"
    to_port   = 80
  }
}