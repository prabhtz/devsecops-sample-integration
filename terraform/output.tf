output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.devsecops_instance.public_ip
}

output "app_url" {
  description = "App URL"
  value       = "http://${aws_instance.devsecops_instance.public_ip}:${var.app_port}"
}

output "monitoring_instance_ip" {
  description = "Public IP of the monitoring EC2 instance"
  value       = aws_instance.monitoring_instance.public_ip
}
