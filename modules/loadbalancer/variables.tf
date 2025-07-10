variable "subnet_ids" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for ALB"
  type        = string
}
variable "instance_a_id" {
  description = "instance a id"
}
variable "instance_b_id" {
  description = "instance bid"
}
variable "instance_c_id" {
  description = "instance c id"
}
variable "alb_security_group_id" {
  description = "iindtance sg id"
}


