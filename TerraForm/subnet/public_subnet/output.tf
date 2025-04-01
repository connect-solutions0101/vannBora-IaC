output "id_subnet" {
    value = aws_subnet.public_subnet_terraform.id
    description = "ID of the VPC"
}