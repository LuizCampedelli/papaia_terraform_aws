# Create Terra VPC
resource "aws_vpc" "terra_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Terra_VPC"
  }
}

# Create Terra Internet Gateway
resource "aws_internet_gateway" "igw-terra" {
  vpc_id = aws_vpc.terra_vpc.id
  tags = {
    Name = "Terra_IGW"
  }
}

# Create Terra Public Subnets
resource "aws_subnet" "terra_public_subnet_1" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Terra_Public_Subnet_1"
  }
}

resource "aws_subnet" "terra_public_subnet_2" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "Terra_Public_Subnet_2"
  }
}

resource "aws_subnet" "terra_public_subnet_3" {
  vpc_id                  = aws_vpc.terra_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "Terra_Public_Subnet_3"
  }
}

# Create Terra Private Subnets
resource "aws_subnet" "terra_private_subnet_1" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terra_Private_Subnet_1"
  }
}

resource "aws_subnet" "terra_private_subnet_2" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Terra_Private_Subnet_2"
  }
}

resource "aws_subnet" "terra_private_subnet_3" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "Terra_Private_Subnet_3"
  }
}

# Create Terra Route Table for Public Subnets

resource "aws_route_table" "terra_public_route" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-terra.id
  }
}


# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "terra_public_subnet_1_association" {
  subnet_id      = aws_subnet.terra_public_subnet_1.id
  route_table_id = aws_route_table.terra_public_route.id
}

resource "aws_route_table_association" "terra_public_subnet_2_association" {
  subnet_id      = aws_subnet.terra_public_subnet_2.id
  route_table_id = aws_route_table.terra_public_route.id
}

resource "aws_route_table_association" "terra_public_subnet_3_association" {
  subnet_id      = aws_subnet.terra_public_subnet_3.id
  route_table_id = aws_route_table.terra_public_route.id
}

# Create allocation ip (Elastic IP)
resource "aws_eip" "terra_nat_eip_1" {
  depends_on = [aws_internet_gateway.igw-terra]
}

resource "aws_nat_gateway" "terra_nat_gateway_1" {
  allocation_id = aws_eip.terra_nat_eip_1.id
  subnet_id     = aws_subnet.terra_public_subnet_1.id
  tags = {
    Name = "Terra_NAT_Gateway_1"
  }
}

# Create allocation ip (Elastic IP)
resource "aws_eip" "terra_nat_eip_2" {
  depends_on = [aws_internet_gateway.igw-terra]
}

resource "aws_nat_gateway" "terra_nat_gateway_2" {
  allocation_id = aws_eip.terra_nat_eip_2.id
  subnet_id     = aws_subnet.terra_public_subnet_2.id
  tags = {
    Name = "Terra_NAT_Gateway_2"
  }
}

# Create allocation ip (Elastic IP)
resource "aws_eip" "terra_nat_eip_3" {
  depends_on = [aws_internet_gateway.igw-terra]
}

resource "aws_nat_gateway" "terra_nat_gateway_3" {
  allocation_id = aws_eip.terra_nat_eip_3.id
  subnet_id     = aws_subnet.terra_public_subnet_3.id
  tags = {
    Name = "Terra_NAT_Gateway_3"
  }
}

# Create Terra Route Table for Private Subnets
resource "aws_route_table" "terra_private_route_1" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra_nat_gateway_1.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table" "terra_private_route_2" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra_nat_gateway_2.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table" "terra_private_route_3" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra_nat_gateway_3.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

# Associate Private Subnets with Private Route Table

resource "aws_route_table_association" "terra_private_subnet_1_association" {
  subnet_id      = aws_subnet.terra_private_subnet_1.id
  route_table_id = aws_route_table.terra_private_route_1.id
}

resource "aws_route_table_association" "terra_private_subnet_2_association" {
  subnet_id      = aws_subnet.terra_private_subnet_2.id
  route_table_id = aws_route_table.terra_private_route_2.id
}

resource "aws_route_table_association" "terra_private_subnet_3_association" {
  subnet_id      = aws_subnet.terra_private_subnet_3.id
  route_table_id = aws_route_table.terra_private_route_3.id
}

# Database Subnet Group

resource "aws_subnet" "terra_private_database_subnet_1" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Terra_Private_Database_Subnet_1"
  }
}

resource "aws_subnet" "terra_private_database_subnet_2" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Terra_Private_Database_Subnet_2"
  }
}

resource "aws_subnet" "terra_private_database_subnet_3" {
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "Terra_Private_Database_Subnet_3"
  }
}

# Route Table Databse

resource "aws_route_table" "terra_private_database_subnet_route" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

# Associate Database Subnets with Database Route Table

resource "aws_route_table_association" "terra_private_subnet_database_association_1" {
  subnet_id      = aws_subnet.terra_private_database_subnet_1.id
  route_table_id = aws_route_table.terra_private_database_subnet_route.id
}

resource "aws_route_table_association" "terra_private_subnet_database_association_2" {
  subnet_id      = aws_subnet.terra_private_database_subnet_2.id
  route_table_id = aws_route_table.terra_private_database_subnet_route.id
}

resource "aws_route_table_association" "terra_private_subnet_database_association_3" {
  subnet_id      = aws_subnet.terra_private_database_subnet_3.id
  route_table_id = aws_route_table.terra_private_database_subnet_route.id
}
