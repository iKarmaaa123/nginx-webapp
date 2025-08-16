output "public_ip" {
    value = aws_instance.webapp[*].public_ip
}

output "ec2_instance" {
    value = aws_instance.webapp[*].id
}