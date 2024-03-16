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

resource "aws_subnet" "private_us_east_1a" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private_us_east_1a"
  }

}

resource "aws_subnet" "private_us_east_1b" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private_us_east_1b"
  }

}

resource "aws_subnet" "public_us_east_1a" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_us_east_1a"
  }

}

resource "aws_subnet" "public_us_east_1b" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public_us_east_1b"
  }

}