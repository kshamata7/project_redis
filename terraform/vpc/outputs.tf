output "vpc_id" {
  value = aws_vpc.new_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

 output "private_subnet_02" {
   value = aws_subnet.private_subnet_02
 }


output "private_subnet_02_id" {
  value = aws_subnet.private_subnet_02.id  # Ensure this ID is defined in your VPC setup
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}

