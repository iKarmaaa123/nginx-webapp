// vpc name 
variable "vpc_name" {
    type = string
    default = ""
}

// subnet name
variable "subnet_name" {
    type = string
    default = ""
}

// cidr block value for vpc
variable "vpc_cidr_block" {
    type = string
    default = ""
}

// cidr block values for public subnets
variable "public_subnet_cidr_block" {
    type = list
    default = []
}

// cidr block values for public subnets
variable "private_subnet_cidr_block" {
    type = list
    default = []
}

// availability zones 
variable "availability_zones" {
    type = list
    default = []
}

// environment
variable "environment" {
    type = string
    default = ""
}

#fndnkdnsdn