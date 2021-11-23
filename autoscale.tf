resource "aws_launch_template" "mustafa_launch_template" {
  name_prefix   = "foobar"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3a.nano"
}

resource "aws_autoscaling_group" "mustafa_asg" {
  availability_zones = ["${var.region}a", "${var.region}a"]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 5

  launch_template {
    id      = aws_launch_template.mustafa_launch_template.id
    version = "$Latest"
  }
}