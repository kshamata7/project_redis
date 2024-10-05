# Bastion EC2 Instance
resource "aws_instance" "bastion" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t2.small"
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups =   [var.bastion_sg_id]  # Updated

  root_block_device {
    volume_size = 10
    # volume_type = "gp3"  # Optional optimization
  }

  tags = {
    Name        = "Bastion Host"

  }
}

# Private EC2 Instance (Tool) in First Private Subnet
resource "aws_instance" "private_ec2" {
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t3.medium"
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_sg_id]  # Updated

  root_block_device {
    volume_size = 40
    # volume_type = "gp3"  # Optional optimization
  }

  tags = {
    Name        = "Private EC2"
  
  }
}

# Private EC2 Instance (Tool) in Second Private Subnet
resource "aws_instance" "private_ec2_02" {  # Renamed for uniqueness
  ami           = "ami-0a0e5d9c7acc336f1"
  instance_type = "t3.medium"
  key_name      = var.key_name
  subnet_id     = var.private_subnet_02  # Ensure consistency with variables
  security_groups = [var.private_sg_id]  # Updated

  root_block_device {
    volume_size = 40
    # volume_type = "gp3"  # Optional optimization
  }

  tags = {
    Name        = "Private EC2 02"
 
  }
}
