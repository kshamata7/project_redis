variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Update as needed
}

variable "public_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"  # Update as needed
}

variable "private_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.2.0/24"  # Update as needed
}

variable "private_cidr_02" {
  description = "CIDR block for the second private subnet"
  type        = string
  default     = "10.0.3.0/24"  # Update as needed
}

variable "availability_zones" {
  description = "List of availability zones to be used"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]  # Update as per your region
}

