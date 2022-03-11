variable "db-ami" {
  type = string
}

resource "aws_instance" "db_server" {
  count             = 2
  ami               = var.db-ami
  instance_type     = var.instance-type
  availability_zone = var.availability_zone[count.index]
  subnet_id = aws_subnet.private_subnet.*.id[count.index]
  vpc_security_group_ids  = [aws_security_group.ec2-private.id]
  key_name = aws_key_pair.opsschool.id
  tags = {
    Name    = "db-server-${count.index + 1}"
    env = var.tags_env
  }
}