
resource "aws_security_group" "instance_sg" {
  for_each = var.instances

  name        = "${each.value.name}-sg"
  vpc_id      = aws_vpc.my-vpc.id
  description = "Security Group para ${each.value.name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-${each.value.name}"
  }
}