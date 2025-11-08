// creating ec2 instance to install nginx on
resource "aws_instance" "webapp" {
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.my_aws_subnet.id
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data = var.user_data

  tags = {
    Name = "${var.environment}-nginx-webapp"
  }
}

// VPC
resource "aws_vpc" "my_aws_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "my_aws_subnet" {
  vpc_id     = aws_vpc.my_aws_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.environment}-subent"
  }
}

// security group
resource "aws_security_group" "my_security_group" {
  name        = "dev_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id = aws_vpc.my_aws_vpc.id
  
  tags = {
    Name = "${var.environment}-nginx-security_group"
  }
}

// security group rule to Accept port 80 requests that will come from the ALB
resource "aws_security_group_rule" "ingress_port_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_aws_vpc.id

  tags = {
    Name = "${var.environment}-internet-gateway"
  }
}

// retrieving ami id from AWS for ec2 instance
data "aws_ami" "amzlinux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Amazon
}


resource "aws_route_table" "example" {
  vpc_id = aws_vpc.my_aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "my_aws_route_table_association" {
  subnet_id      = aws_subnet.my_aws_subnet.id
  route_table_id = aws_route_table.example.id
}

// allocating public ip address to ec2 instance
resource "aws_eip" "my_aws_eip" {
  depends_on = [aws_instance.webapp]
  instance = aws_instance.webapp.id
  domain   = "vpc"
}

