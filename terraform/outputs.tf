output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public_1a.id
}

output "public_subnet_1b_id" {
  value = aws_subnet.public_1b.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private_1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private_1b.id
}

output "igw_id" {
  value = aws_internet_gateway.dev_igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.dev_nat.id
}
