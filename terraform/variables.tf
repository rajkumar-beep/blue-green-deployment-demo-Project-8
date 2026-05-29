variable "region" {
  default = "ap-south-1"
}

variable "vpc_name" {
    default = "DEV_VPC"
  
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
  
}

variable "pub1_cidr" {
    default = "10.0.1.0/24"
  
}

variable "pri1_cidr" {
    default = "10.0.2.0/24"
  
}

variable "pub2_cidr" {
    default = "10.0.3.0/24"
  
}

variable "pri2_cidr" {
    default = "10.0.4.0/24"
  
}


variable "az1" {
    default = "ap-south-1a"
  
}

variable "az2" {
    default = "ap-south-1b"
  
}


variable "igw_name" {
    default = "DEV_IGW"
  
}

variable "nat_name" {
  default = "DEV_NATGATEWAY"
}
