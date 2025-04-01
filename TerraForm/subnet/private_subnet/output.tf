output "id_subnet" {
    value = aws_subnet.private_subnet_terraform.id
    description = "ID of the VPC"
}