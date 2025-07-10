variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EC2 instances"
  type        = string
}

variable "alb_security_group_id" {
  description = "The ID of the ALB security group"
  type        = string
}