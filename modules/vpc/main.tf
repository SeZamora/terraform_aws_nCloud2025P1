locals {
  true_owner = "${var.owner}-nclouds-2026"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name    = "jorge0509-${var.project_name}"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_subnet" "public_subnets" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 1 + count.index)
  availability_zone = "us-west-2${element(["a", "b"], count.index)}"

  tags = {
    Name    = "jorge0509-Public-${count.index + 1}"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_subnet" "private_subnets" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 4 + count.index)
  availability_zone = "us-west-2${element(["a", "b"], count.index)}"

  tags = {
    Name    = "jorge0509-Private-${count.index + 1}"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "jorge0509-IGW"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "jorge0509-Public-RT"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "jorge0509-Private-RT"
    Owner   = local.true_owner
    Project = var.project_name
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count          = 2
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.ipElastic
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name    = "jorge0509-NAT-GW"
    Owner   = local.true_owner
    Project = var.project_name
  }

    depends_on = [aws_internet_gateway.igw]

}

resource "aws_route" "private_nat"{
    route_table_id         = aws_route_table.private_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_gw.id
}


