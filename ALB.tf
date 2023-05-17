resource "aws_lb" "example" {
  name               = "example-alb"
  load_balancer_type = "application"
  subnets            = ["aws_subnet.public-us-east-1a.id", "aws_subnet.public-us-east-1ab.id"]  # Replace with your subnet IDs

  security_groups = ["sg-12345678"]  # Replace with your security group IDs

  tags = {
    Name = "example-alb"
  }
}

resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = var.app_port  # Specify the port using a variable
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

resource "aws_lb_target_group" "example" {
  name        = "example-target-group"
  port        = var.app_port  # Specify the port using a variable
  protocol    = "HTTP"
  target_type = "instance"

  vpc_id = aws_vpc.main.id  # Replace with your VPC ID

  health_check {
    path = "/health"
  }
}