// region name
variable "region" {
    type = string
    default = ""
}

// cidr block value for vpc
variable "vpc_cidr_block" {
    type = string
    default = ""
}

// environment
variable "environment" {
    type = string
    default = ""
}