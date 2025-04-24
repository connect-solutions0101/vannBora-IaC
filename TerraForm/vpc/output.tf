output "id_vpc" {
    value = aws_vpc.virtual_vannbora_cloud.id
    description = "ID of the VPC"
}

output "instance_security_grupo" {
  value = aws_security_group.vannbora_sg.id
  description = "value of the security group"
}