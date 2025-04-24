resource "aws_vpc" "virtual_vannbora_cloud" {
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"
    

    tags = {
        Name = "vpc_terraform"
    }
}



resource "aws_internet_gateway" "ig_vannbora" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id

  tags = {
    Name = "ig_terraform"
  }
}

resource "aws_eip" "epi_vannbora" {
  vpc = true

  tags = {
    Name = "eip_terraform"
  }
}

resource "aws_nat_gateway" "nat_vannbora" {
  allocation_id = aws_eip.epi_vannbora.id
  subnet_id     = var.variable_subnet_id_public

  tags = {
    Name = "nat_terraform"
  }
}




resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id
}
resource "aws_route_table_association" "private_internet" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id      = var.variable_subnet_id_private
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id

  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.ig_vannbora.id
  }

  tags = {
    Name = "internet_gateway_terraform"
  }
}
resource "aws_route_table_association" "tabela_publica" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id = var.variable_subnet_id_public
}




resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.virtual_vannbora_cloud.id
  subnet_ids = [var.variable_subnet_id_public]

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 32000
    to_port    = 65535
  }
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "vannbora-cloud"
  }
}

resource "aws_security_group" "vannbora_sg" {
  name        = "basic_security"
  description = "docker and http(s)"
  vpc_id      = aws_vpc.virtual_vannbora_cloud.id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}