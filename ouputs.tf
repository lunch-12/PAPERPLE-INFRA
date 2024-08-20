output "jenkins_public_ip" {
  value = aws_eip.current_ip.public_ip
}

output "rds" {
  value = module.rds.database
}

output "eks_endpoint" {
  value = module.eks.endpoint
}

output "kubeconfig-ca" {
  value = module.eks.kubeconfig-certificate-authority-data
}