module "ec2-nginx" {
  source = "./modules/ec2"
  number_of_server = 2
  ami_id = var.nginx-ami
  instance_type = var.instance-type
  availability_zone = var.availability_zone
  subnet_id = aws_subnet.public_subnet.*.id
  vpc_security_group_ids = [aws_security_group.ec2-public.id]
  iam_instance_profile = aws_iam_instance_profile.ec2-role.name
  key_name = aws_key_pair.opsschool.id
}