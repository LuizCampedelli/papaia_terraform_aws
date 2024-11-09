resource "aws_lb" "papaia" {
  name               = "papaia-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["terra_public_subnet_1", "terra_public_subnet_2", "terra_public_subnet_3"]

  enable_deletion_protection = false

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "papaia-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "papaia" {
  name     = "papaia-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra_vpc.id
}

resource "aws_lb_target_group_attachment" "papaia_instance_1" {
  target_group_arn = aws_lb_target_group.papaia.arn      # Reference the declared target group
  target_id        = aws_instance.terra_private_ec2_1.id # Attach the first instance
  port             = 80                                  # Port where the application is listening
}

resource "aws_lb_target_group_attachment" "papaia_instance_2" {
  target_group_arn = aws_lb_target_group.papaia.arn      # Reference the declared target group
  target_id        = aws_instance.terra_private_ec2_2.id # Attach the second instance
  port             = 80                                  # Port where the application is listening
}

resource "aws_lb_target_group_attachment" "papaia_instance_3" {
  target_group_arn = aws_lb_target_group.papaia.arn      # Reference the declared target group
  target_id        = aws_instance.terra_private_ec2_3.id # Attach the third instance
  port             = 80                                  # Port where the application is listening
}

resource "aws_lb_listener" "papaia" {
  load_balancer_arn = aws_lb.papaia.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.papaia.arn
  }
}
