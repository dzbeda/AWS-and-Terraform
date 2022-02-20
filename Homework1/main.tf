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
  access_key = ""
  secret_key = ""
}

resource "aws_ebs_volume" "nginx_disk" {
  count = 2
  availability_zone = "us-east-1a" #Do i need to spcifiy it in both ec2 and volume resources?
  size              = 10
  encrypted = "true"
  type = "gp2"

  tags = {
    Name = join("nginx volume",[count.index])
    purpose ="web site server"
  }
}

resource "aws_instance" "nginx_server" {
  count = 2
  ami           = "ami-04505e74c0741db8d"  #This is ubuntu 20 ami
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
echo "<h1>Welcome to Grandpa's Whiskey</h1>" | sudo tee /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
  tags = {
    Name = join("nginx server ",[count.index])
    owner = "dudu"
    purpose ="web site server"
  }
}

resource "aws_volume_attachment" "nginx_volume" {
  count = 2
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.nginx_disk.*.id[count.index]
  instance_id = aws_instance.nginx_server.*.id[count.index]
}
