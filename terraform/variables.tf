variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "DevPemKey"
}

variable "peer_vpc_id" {
  description = "The ID of the existing VPC to peer with"
  default     = "vpc-09516b6e0d869c1d8"
}

variable "private_subnet_02_id" {
  type = string
  
}
