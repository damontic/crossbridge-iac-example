resource "aws_lb" "main" {
  name               = "public"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public.id]

  #access_logs {
  #  bucket  = aws_s3_bucket.lb_logs.id
  #  prefix  = "test-lb"
  #  enabled = true
  #}
}


#resource "aws_lb_target_group" "tg" {
#  name        = "tg"
#  target_type = "ip"
#  port        = 80
#  protocol    = "TCP"
#  vpc_id      = aws_vpc.main.id
#}
