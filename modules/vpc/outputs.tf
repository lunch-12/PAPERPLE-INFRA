output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway" {
  value = aws_internet_gateway.main.id
}

output "igw-table" {
  value = aws_route_table.igw-table.id
}

output "nat-table" {
  value = aws_route_table.nat-table.id
}

output "db-nat-table" {
  value = aws_route_table.db-nat-table.id
}