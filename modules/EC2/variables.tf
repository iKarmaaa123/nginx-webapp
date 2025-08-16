variable "ec2_count" {
    type = number
    default = 0
}

variable "eip_count" {
    type = number
    default = 0
}

variable "instance_type" {
    type = string
    default = ""
}

variable "region"{
    type = string
    default = ""
}

variable "key_name" {
    type = string
    default = ""
}

variable "vpc_name" {
    type = string
    default = ""
}

variable "subnet_name" {
    type = string
    default = ""
}

variable "vpc_id" {
    type = string
    default = ""
}

variable "subnet_ids" {
    type = list
    default = []
}

variable "security_group_ids" {
    type = list
    default = []
}

variable "environment" {
    type = string
    default = ""
}

variable "user_data" {
    type = string
    default = ""
}

variable "domain" {
  type = string
  default = ""
}

variable "owners" {
    type = list(string)
    default = [""]
}
