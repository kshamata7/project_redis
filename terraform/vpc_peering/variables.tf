variable "vpc_id" {
    type = string
}
variable "peer_vpc_id" {
    type = string
}
variable "public_route_table_id" {
    type = string
}
variable "private_route_table_id" {
    type = string
}

variable "existing_route_table_id" {
  description = "The ID of the existing route table in the peer VPC"
  default     = "rtb-06bca5b8755e70050"  # Your specified route table ID
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the new VPC"
  default     = "10.0.0.0/16"  # CIDR of the new VPC being created
}

variable "peer_vpc_cidr_block" {
  description = "The CIDR block of the existing VPC"
  default     = "172.31.0.0/16"  # CIDR of the existing VPC (vpc-09516b6e0d869c1d8)
}
