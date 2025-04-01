resource "aws_instance" "public_ec2" {
    ami                     = "ami-084568db4383264d4"
    instance_type           = "t2.micro"
    subnet_id = var.instance_public_subnet
    # vpc_security_group_ids = [var.instance_security_grupo]
    associate_public_ip_address = true

    ebs_block_device {
        device_name         = "/dev/sda1"
        volume_size         = 8
        volume_type         = "standard"
    }

    depends_on = [ var.instance_vpc ]

    tags = {
        Name = "public_ec2"
    }
}

resource "aws_instance" "private_ec2" {
    ami                     = "ami-084568db4383264d4"
    instance_type           = "t2.micro"
    subnet_id = var.instance_private_subnet
    # vpc_security_group_ids = [var.instance_security_grupo]

    ebs_block_device {
        device_name         = "/dev/sda1"
        volume_size         = 8
        volume_type         = "standard"
    }

    depends_on = [ var.instance_vpc ]

    tags = {
        Name = "private_ec2"
    }
}