resource "aws_subnet" "private_subnet_terraform" {
    vpc_id = var.variable_id_vpc
    cidr_block = "10.0.0.128/25"

    # depends_on = [ 
    #   module.aws_vpc.virtual_vannbora_cloud
    # ]

    tags = {
      Name = "vannbora-cloud-public-subnet"
      }
}