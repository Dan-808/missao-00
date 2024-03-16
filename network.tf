resource "aws_vpc" "my-vpc" { #criando uma vpc
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}


resource "aws_internet_gateway" "igw" { #igw fornece acesso a internet para as subredes
  vpc_id = aws_vpc.my-vpc.id
  

  tags = {
    Name = "igw"
  }

}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nat"
  }

}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_us_east_1a.id

  tags = {
    Name = "nat"
  }
  
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
Name = "private"
}
}

resource "aws_route" "privateroute" {
  
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.private.id
    nat_gateway_id = aws_nat_gateway.nat.id

}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.my-vpc.id
    
    tags = {
Name = "public"
}
}

resource "aws_route" "publicroute" {
  
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.public.id
    gateway_id = aws_internet_gateway.igw.id


}



resource "aws_route_table_association" "private_us_east_1a" {
    subnet_id = aws_subnet.private_us_east_1a.id
    route_table_id = aws_route_table.private.id
  
}

resource "aws_route_table_association" "private_us_east_1b" {
    subnet_id = aws_subnet.private_us_east_1b.id
    route_table_id = aws_route_table.private.id
  
}

