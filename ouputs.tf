output "jenkins_public_ip" {
  value = aws_eip.current_ip.public_ip
}

output "rds" {
  value = module.rds.database
}