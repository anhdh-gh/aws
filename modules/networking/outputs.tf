output "vpc_id" {
  value = aws_vpc.this.id
}

output "presentation_public_subnet_id" {
  value = aws_subnet.public_subnet_presentation.id
}

output "app_subnet_id" {
  value = aws_subnet.private_subnet_app.id
}

