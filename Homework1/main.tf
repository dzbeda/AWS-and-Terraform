terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# configure provider
provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_key
  secret_key = var.aws_secret
}

resource "aws_ebs_volume" "nginx_disk" {
  count             = 2
  availability_zone = "us-east-1a" #Do i need to spcifiy it in both ec2 and volume resources?
  size              = 10
  encrypted         = "true"
  type              = "gp2"

  tags = {
    Name    = "nginx-volume-${count.index + 1}"
    purpose = "web site server"
    owner   = var.owner
  }
}

resource "aws_instance" "nginx_server" {
  count             = 2
  ami               = "ami-04505e74c0741db8d" #This is ubuntu 20 ami
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  user_data = templatefile("./nginx-userdata.tpl", {
    server_id = count.index + 1
    }
  )
  tags = {
    Name    = "nginx-server-${count.index + 1}"
    owner   = var.owner
    purpose = "web site server"
  }
}

resource "aws_volume_attachment" "nginx_volume" {
  count       = 2
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx_disk.*.id[count.index]
  instance_id = aws_instance.nginx_server.*.id[count.index]
}
