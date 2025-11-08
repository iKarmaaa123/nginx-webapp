# output "vpc_id" {
#     value = aws_vpc.my_vpc.id
# }

output "vpc_cidr_block" {
    value = aws_vpc.my_vpc.cidr_block
}

# output "public_subnet_id" {
#     value = aws_subnet.public_subnet.id
# }

# output "public_subnet_id_2" {
#     value = aws_subnet.public_subnet-2.id
# }

output "public_subnet_cidr_block" {
  value = aws_subnet.public_subnet.cidr_block
}

output "public_subnet_cidr_block_2" {
  value = aws_subnet.public_subnet_2.cidr_block
}

output "private_subnet_id" {
    value = aws_subnet.private_subnet.id
}

output "private_subnet_id2" {
    value = aws_subnet.private_subnet_2.id
}

output "private_subnet_cidr_block" {
  value = aws_subnet.private_subnet.cidr_block
}

output "private_subnet_cidr_block_2" {
  value = aws_subnet.private_subnet_2.cidr_block
}

