data "aws_ami" "ecs_opt" {
  most_recent      = true
  name_regex       = ".*2023.*ecs.*optim.*"
}

resource "aws_launch_template" "lt" {
  name_prefix   = "ecs_opt_2023"
  image_id      = data.aws_ami.ecs_opt.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.david.key_name
  network_interfaces {
    subnet_id = aws_subnet.private.id
  }
}

resource "aws_autoscaling_group" "asg" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
}
