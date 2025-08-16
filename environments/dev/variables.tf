// region
variable "region" {
    type = string
    default = ""
}

// vpc name
variable "vpc_name" {
    type = string
    default = ""
}

// ids for subnets
variable "subnet_ids" {
    type = string
    default = ""
}

// name for subnet
variable "subnet_name" {
    type = string
    default = ""
}

// vpc cidr block
variable "vpc_cidr_block" {
    type = string
    default = ""
}

// vpc cidr block
variable "public_subnet_cidr_block" {
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

// instance type
variable "instance_type" {
    type = string
    default = ""
}

// count for the number of ec2 instances
variable "ec2_count" {
    type = number
    default = 0
}

// key name for instance
variable "key_name" {
    type = string
    default = ""
}

// user_data for scripts to install onto ec2 instance
variable "user_data" {
    type = string
    default = ""
}

// number of elastic ip addresses
variable "eip_count" {
    type = number
    default = 0
}

variable "domain" {
  type = string
  default = ""
}
