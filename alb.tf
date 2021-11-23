resource "aws_alb" "mustafa_lb" {
  name            = "mustafa-lb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]

  depends_on = [aws_vpc.mustafa_vpc, aws_security_group.lb, aws_subnet.public]
}

resource "aws_lb_target_group" "default_target_group" {
  name     = "default-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.mustafa_vpc.id
}

resource "aws_alb_listener" "http_80" {
  load_balancer_arn = aws_alb.mustafa_lb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.default_target_group.id
    type             = "forward"
  }

  depends_on = [aws_alb.mustafa_lb]
}
