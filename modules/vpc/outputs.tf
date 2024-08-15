output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway" {
  value = aws_internet_gateway.main.id
}

output "route_table" {
  value = aws_route_table.main.id
}
