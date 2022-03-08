variable "nginx-ami" {
  type = string
}
variable "instance-type" {
  type = string
  default = "t2.micro"
}
resource "aws_instance" "nginx_server" {
  count             = 2
  ami               = var.nginx-ami
  instance_type     = var.instance-type
  availability_zone = var.availability_zone[count.index]
  subnet_id = aws_subnet.public_subnet.*.id[count.index]
  vpc_security_group_ids  = [aws_security_group.ec2-public.id]
  key_name = aws_key_pair.opsschool.id
  user_data = templatefile("./nginx-userdata.tpl", {
    server_id = count.index + 1
    }
  )
  tags = {
    Name    = "nginx-server-${count.index + 1}"
    env = var.tags_env
  }
}

resource "aws_ebs_volume" "nginx_disk" {
  count             = 2
  availability_zone = var.availability_zone[count.index]
  size              = 10
  encrypted         = "true"
  type              = "gp2"

  tags = {
    Name    = "nginx-volume-${count.index + 1}"
    env = var.tags_env
  }
}

resource "aws_volume_attachment" "nginx_volume" {
  count       = 2
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx_disk.*.id[count.index]
  instance_id = aws_instance.nginx_server.*.id[count.index]
}