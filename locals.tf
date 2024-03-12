locals {
  html_filepath = "viacep.html" #identifica onde ta o arquivo

  common_tags = {
    Name        = "Bucket mentoria"
    Owner       = "Daniel Correa"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

}