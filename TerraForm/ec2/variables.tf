variable "instance_vpc" {
  type = string
  default = ""
  description = ""
}

variable "instance_public_subnet" {
  type = string
  default = ""
  description = ""
}

variable "instance_private_subnet" {
    type = string
    default = ""
    description = ""
}

variable "instance_security_grupo"{
    type = string
    default = ""
    description = ""
}

variable "ami" {
  type = string
  default = "ami-084568db4383264d4"
  description = "versão SO - 23/04"
}