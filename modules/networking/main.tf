# ---------------------------- VPC ----------------------------
resource "aws_vpc" this {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "3tier-vpc"
  }
}

# ---------------------------- IGW ----------------------------
resource "aws_internet_gateway" this {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "3tier-igw"
  }
}

# ---------------------------- Subnets ----------------------------
# Public
resource "aws_subnet" public_subnet_presentation {
  vpc_id = aws_vpc.this.id

  cidr_block = var.public_subnet_presentation_cidr
  availability_zone = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-presentation"
  }
}

# Private
resource "aws_subnet" private_subnet_app {
  vpc_id = aws_vpc.this.id

  cidr_block = var.private_subnet_app_cidr
  availability_zone = var.az

  tags = {
    Name = "private-subnet-app"
  }
}

resource "aws_subnet" private_subnet_db {
  vpc_id = aws_vpc.this.id

  cidr_block = var.private_subnet_db_cidr
  availability_zone = var.az

  tags = {
    Name = "private-subnet-db"
  }
}

# ---------------------------- Public Route table ----------------------------
resource "aws_route_table" public_route_table {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" public_route {
  route_table_id = aws_route_table.public_route_table.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" public_route_table_association {
  subnet_id = aws_subnet.public_subnet_presentation.id
  route_table_id = aws_route.public_route.id
}

# ---------------------------- Private Route table ----------------------------
# resource "aws_eip" nat {
#   domain = "vpc"
# }
#
# resource "aws_nat_gateway" this {
#   subnet_id = aws_subnet.public_subnet_presentation.id
#   allocation_id = aws_eip.nat.id
# }
#
# resource "aws_route_table" private_route_table {
#   vpc_id = aws_vpc.this.id
#
#   tags = {
#     Name = "private-rt"
#   }
# }
#
# resource "aws_route" private_nat {
#   route_table_id = aws_route_table.private_route_table.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id = aws_nat_gateway.this.id
# }
#
# resource "aws_route_table_association" private_route_table_association_app {
#   subnet_id = aws_subnet.private_subnet_app.id
#   route_table_id = aws_route_table.private_route_table.id
# }
#
# resource "aws_route_table_association" private_route_table_association_db {
#   subnet_id = aws_subnet.private_subnet_db.id
#   route_table_id = aws_route_table.private_route_table.id
# }