resource "aws_alb" "my-alb" {
  name            = "My-LB"
  internal        = "false"

  subnets         = ["${var.subnets}"]
  security_groups = ["${split(",", aws_security_group.alb_sg.id)}"]

  tags {
    Name    = "My-LB-Tag"
  }
}

resource "aws_alb_listener" "alb_listener" {
  port              = "${var.lb_port}"
  protocol          = "${var.lb_protocol}"

  load_balancer_arn = "${aws_alb.my-alb.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "listener_rule" {
  priority     = "100"

  listener_arn = "${aws_alb_listener.alb_listener.arn}"
  depends_on   = ["aws_alb_target_group.alb_target_group"]

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "my-target-group"
  target_type = "ip"  # A MUST for fargate
  port     = "${var.lb_target_group_port}"
  protocol = "${var.lb_target_group_protocol}"
  vpc_id   = "${var.vpc_id}"

  //In order to avoid ": InvalidParameterException: The target group with targetGroupArn does not have an associated load balancer."
  //https://github.com/hashicorp/terraform/issues/12634
  depends_on = [ "aws_alb.my-alb",]


  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30

    path                = "/"
    port                = "${var.lb_target_group_port}"
    timeout             = 5
  }

  tags {
    name = "target-group-name"
  }
}