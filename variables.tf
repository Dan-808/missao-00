variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"

}

variable "aws_profile" {
  type        = string
  description = ""
  default     = "user-cli"

}

variable "instance_ami" {
  type    = string
  default = "ami-07d9b9ddc6cd8dd30"

}

variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro"

}

variable "instance_tags" {
  type        = map(string)
  description = ""
  default = {

    Owner            = "Daniel Correa"
    ManagedBy        = "Terraform"
    Environment      = "Dev"
    Project          = "Mentoria SRE"
    AvailabilityZone = "az"
  }

}

variable "environment" {
  type        = string
  description = ""
  default     = "dev" #tem que ser unico no mundo todo
}

variable "bucket" {
  type        = string
  description = ""
  default     = "my-bucket-mentoring8089925" #tem que ser unico no mundo todo
}

variable "subnet_cidr" {
  description = "CIDR das Subnets"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "availability_zones" {
  type    = set(string)
  default = (["us-east-1a", "us-east-1b"])
}

variable "instances" {
  description = "Informações para criar as instâncias EC2 e Security Groups"
  type = map(object({
    name : string
    subnet_id : string
  }))

  default = {
    "instance1" : {
      name : "EC2Instance1",
      subnet_id : "subnet-0a3af37d5bbe6af5d" # Substitua pelo ID da sua subnet na primeira zona de disponibilidade
    },
    "instance2" : {
      name : "EC2Instance2",
      subnet_id : "subnet-09bbad62513d5ca5e" # Substitua pelo ID da sua subnet na segunda zona de disponibilidade
    }
  }
}