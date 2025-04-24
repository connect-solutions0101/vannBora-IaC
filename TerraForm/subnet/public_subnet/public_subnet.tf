resource "aws_subnet" "public_subnet_terraform" {
    vpc_id = var.variable_id_vpc
    cidr_block = "10.0.0.0/25"

    tags = {
      Name = "vannbora-cloud-public-subnet"
    }
}