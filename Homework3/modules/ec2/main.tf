resource "aws_instance" "nginx_server" {
  count             = var.number_of_server
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = var.availability_zone[count.index]
  subnet_id = var.subnet_id[count.index]
  vpc_security_group_ids  = var.vpc_security_group_ids
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile
  user_data = templatefile("./nginx-userdata.tpl", {
    server_id = count.index + 1
    }
  )
  tags = {
    Name    = "nginx-server-${count.index + 1}"
    //env = var.tags_env
  }
}