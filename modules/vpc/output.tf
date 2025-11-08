output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "internet_gateway" {
    value = aws_internet_gateway.my_internet_gateway
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
    value = aws_subnet.private_subnets[*].id
}

output "security_group_ids" {
    value = aws_security_group.my_security_group.id
}

output "vpc_cidr_block" {
    value = aws_vpc.my_vpc.cidr_block
}

output "public_subnet_cidr_block" {
  value = aws_subnet.public_subnets[*].cidr_block
}
