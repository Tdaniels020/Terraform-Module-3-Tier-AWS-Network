output "region" {
value = var.region
}

output "project_name" {
value = var.project_name
}

output "vpc_id" {
value = aws_vpc.vpc.id
}

output "private_AZ" {
value = var.private_AZ
}

output "public_AZ" {
value = var.public_AZ
}

output "public_subnets_id" {
value = aws_subnet.public_subnets.id
}

output "private_subnets_id" {
value = aws_subnet.private_subnets.id
}


output "aws_internet_gateway" {
value = aws_internet_gateway.IGW
}
