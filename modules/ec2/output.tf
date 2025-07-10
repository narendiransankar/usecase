output "instance_a_id" {
  description = "ID of Instance A (Homepage)"
  value       = aws_instance.instance_a.id
}

output "instance_b_id" {
  description = "ID of Instance B (Images)"
  value       = aws_instance.instance_b.id
}

output "instance_c_id" {
  description = "ID of Instance C (Register)"
  value       = aws_instance.instance_c.id
}
output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}