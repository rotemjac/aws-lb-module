variable "vpc_id" {
  description = ""
  default     = ""
}

variable "subnets" {
  description = ""
  default     = [],
  type        = "list"
}


variable "lb_protocol" {
  description = ""
  default     = ""
}

variable "lb_port" {
  description = ""
  default     = ""
}


variable "lb_target_group_protocol" {
  description = ""
  default     = ""
}

variable "lb_target_group_port" {
  description = ""
  default     = ""
}

