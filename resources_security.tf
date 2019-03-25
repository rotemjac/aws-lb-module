# ALB security group
resource "aws_security_group" "alb_sg" {
  name        = "ALb-sg"
  description = "Manage traffic rules for the ALB"

  vpc_id      = "${var.vpc_id}"


  #Inbound -  HTTP access from anywhere
  ingress {
    from_port   = "${var.lb_sg_from_port}"
    to_port     = "${var.lb_sg_to_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #Outbound - allow internet access for software updates
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
