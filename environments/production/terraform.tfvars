region = "us-east-1"
vpc_name = "my_vpc"
vpc_cidr_block = "10.0.0.0/16"
public_subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
instance_type = "t2.micro"
ec2_count = 2
eip_count = 2
environment = "Prod"
user_data = <<-EOF
  #!/bin/bash
  sudo amazon-linux-extras install -y nginx1.12
  sudo systemctl start nginx
  sudo systemctl enable nginx
  EOF
