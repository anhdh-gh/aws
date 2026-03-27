output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip_ec2" {
  value = aws_instance.this.public_ip
}