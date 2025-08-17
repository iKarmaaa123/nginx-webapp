// output value for public_ip
output "public_ip" {
    value = aws_instance.webapp.public_ip
}