resource "aws_alb" "nginx-alb" {
  name = "nginx-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb.id]
  subnets = [for subnet in aws_subnet.public_subnet.*.id : subnet]
  tags = {
    Name = "main"
    env = var.tags_env
  }
}

resource "aws_alb_target_group" "nginx" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-main.id
}

resource "aws_alb_target_group_attachment" "nginx" {
  count = 2
  target_group_arn = aws_alb_target_group.nginx.arn
  target_id        = module.ec2-nginx.ec2-nginx-id.*.id[count.index]
  port             = 80
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.nginx-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.nginx.arn
  }
}