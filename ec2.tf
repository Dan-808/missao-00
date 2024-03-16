resource "aws_iam_instance_profile" "ec2_s3_read_profile" {
  name = "ec2-s3-read-profile"
  role = aws_iam_role.ec2_s3_read_role.name

}
      
module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = var.instances

  name                   = each.value.name
  ami                    = var.instance_ami # Substitua pelo ID da AMI desejada
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  monitoring             = true
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = [aws_security_group.instance_sg[each.key].id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_read_profile.name

  tags = {
    Name = each.value.name


  }
  depends_on = [aws_iam_instance_profile.ec2_s3_read_profile]

  

  user_data = <<-EOF
                  #!/bin/bash
                  sudo apt-get update
                  sudo apt-get install -y nginx
                  sudo systemctl start nginx
                  sudo systemctl enable nginx
                  EOF
}
