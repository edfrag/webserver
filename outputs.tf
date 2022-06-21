output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.webserver[*].public_ip
}

output "instance_id" {
    description = "Instance id"
    value       = aws_instance.webserver[*].id
}

output "security_group_id" {
    description = "Security Group id"
    value       = aws_security_group.standard.id
}


