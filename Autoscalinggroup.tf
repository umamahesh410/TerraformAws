resource "aws_launch_configuration" "example" {
  name_prefix          = "example-lc-"
  image_id             = "ami-12345678"  # Replace with your desired AMI ID
  instance_type        = "t2.micro"      # Replace with your desired instance type
  security_group_names = ["example-sg"]  # Replace with your security group names
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  name                      = "example-asg"
  max_size                  = 5               # Replace with your desired max size
  min_size                  = 1               # Replace with your desired min size
  desired_capacity          = 2               # Replace with your desired desired capacity
  health_check_grace_period = 300             # Replace with your desired health check grace period
  launch_configuration      = aws_launch_configuration.example.name
  vpc_zone_identifier       = ["aws_subnet.public-us-east-1a.id", "aws_subnet.public-us-east-1ab.id"]  # Replace with your subnet ID(s)
  
  termination_policies = [
    "OldestInstance",
    "NewestInstance",
    "Default"
  ]

  lifecycle {
    create_before_destroy = true
  }

  metric {
    name = "CPUUtilization"
    unit = "Percent"
  }

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}