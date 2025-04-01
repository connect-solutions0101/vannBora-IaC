resource "aws_instance" "public_ec2" {
    ami                     = "ami-084568db4383264d4"
    instance_type           = "t2.micro"
    subnet_id = var.instance_security_grupo
    security_groups = [var.instance_security_grupo]

    ebs_block_device {
        device_name         = "/dev/sda1"
        volume_size         = 8
        volume_type         = "standard"
    }

    tags = {
        Name = "exemple-app-server"
    }
}

resource "aws_instance" "private_ec2" {
    ami                     = "ami-084568db4383264d4"
    instance_type           = "t2.micro"
    subnet_id = var.instance_private_subnet
    security_groups = [var.instance_security_grupo]

    ebs_block_device {
        device_name         = "/dev/sda1"
        volume_size         = 8
        volume_type         = "standard"
    }

    tags = {
        Name = "exemple-app-server"
    }
}