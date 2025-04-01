resource "aws_vpc" "virtual_vannbora_cloud" {
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"

    tags = {
        Name = "vannbora-cloud"
    }
}



resource "aws_internet_gateway" "ig_vannbora" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id
}

resource "aws_eip" "epi_vannbora" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_vannbora" {
  allocation_id = aws_eip.epi_vannbora.id
  subnet_id     = var.variable_subnet_id_public
  connectivity_type = "public"
}




resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id

  route { 
    cidr_block = "10.0.0.128/25"
    gateway_id = aws_internet_gateway.ig_vannbora.id
   }
}

resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.route_table_private.id
  destination_cidr_block = "10.0.0.0/24"
  nat_gateway_id =      aws_nat_gateway.nat_vannbora.id
}

resource "aws_route_table_association" "tabela_privada" {
  subnet_id      = var.variable_subnet_id_private
  route_table_id = aws_route_table.route_table_private.id
}




resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id

  route { 
    cidr_block = "10.0.0.0/25"
    gateway_id = aws_internet_gateway.ig_vannbora.id
   }

   tags = {
     Name = "vannbora_tag"
   }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "10.0.0.0/24"
  gateway_id             = aws_internet_gateway.ig_vannbora.id
}

resource "aws_route_table_association" "tabela_publica" {
  subnet_id = var.variable_subnet_id_public
  route_table_id = aws_route_table.route_table_public.id
}




resource "aws_network_acl" "acl_vannbora" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id

  ingress {
    rule_no = 100
    action = "allow"
    from_port   = "22"
    to_port     = "22"
    protocol    = "-1"
    cidr_block = "0.0.0.0/0"
    }

  egress {
    rule_no = 100
    action = "allow"
    from_port   = "22"
    to_port     = "22"
    protocol    = "-1"
    cidr_block = "0.0.0.0/0"
    }

  tags = {
    Name = "vannbora-cloud"
  }
}