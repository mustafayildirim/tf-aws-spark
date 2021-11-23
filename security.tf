resource "aws_security_group" "lb" {
  name        = "mustafa-alb"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.mustafa_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
    # prevent_destroy = true
    ignore_changes = [
      name,
      tags,
    ]
  }
}