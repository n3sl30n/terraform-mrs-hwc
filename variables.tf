variable "cluster_name" {
  default = "mrs-analysis-cluster"
}

variable "subnet_name" {
  default = "mrs-cluster-subnet"
}

variable "cluster_password" {
  default = "@Abc123456"
}

variable "subnet_cidr" {
  default = "192.168.1.0/24"
}

variable "sg_description" {
  default = "sg bound to mrs cluster only"
}

variable "subnet_gateway_ip" {
  default = "192.168.1.1"
}

variable "sg_name" {
  default = "sg-mrs-cluster"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  default = "mrs_vpc"
}