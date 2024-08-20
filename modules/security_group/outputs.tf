output "main" {
  value = aws_security_group.main.id
}

output "database" {
  value = aws_security_group.database.id
}