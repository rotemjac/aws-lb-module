output "alb_host" {
  value = "${aws_alb.my-alb.dns_name}"
}

output "alb_target_group_name" {
  value = "${aws_alb_target_group.alb_target_group.name}"
}

output "alb_target_group_arn" {
  value = "${aws_alb_target_group.alb_target_group.arn}"
}

output "alb_sg_name" {
  value = "${aws_security_group.alb_sg.name}"
}

output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}