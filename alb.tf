resource "aws_lb" "papaia" {
  name               = "papaia-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["terra_public_subnet_1", "terra_public_subnet_2", "terra_public_subnet_3"]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.papaia-lb_logs.id
    prefix  = "papaia-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "papaia-tg" {
  name     = "papaia-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra_vpc.id
}

resource "aws_lb_target_group_attachment" "banana" {
  target_group_arn = aws_lb_target_group.banana.arn
  target_id = [aws_instance.terra_private_ec2_1.id,
  aws_instance.terra_private_ec2_2.id, aws_instance.terra_private_ec2_3.id]
  port = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}
