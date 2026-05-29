provider "aws" {
  region = var.region
}

# ── VPC ──────────────────────────────────────────
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# ── SUBNETS ───────────────────────────────────────
resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.pub1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-1a"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.pri1_cidr
  availability_zone = var.az1

  tags = {
    Name = "Private-1a"
  }
}

resource "aws_subnet" "public_1b" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = var.pub2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-1b"
  }
}

resource "aws_subnet" "private_1b" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.pri2_cidr
  availability_zone = var.az2

  tags = {
    Name = "Private-1b"
  }
}

# ── INTERNET GATEWAY ──────────────────────────────
resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# ── ELASTIC IP (needed for NAT) ───────────────────
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# ── NAT GATEWAY (goes in public subnet) ──────────
resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1a.id

  tags = {
    Name = var.nat_name
  }

  depends_on = [aws_internet_gateway.dev_igw]
}

# ── PUBLIC ROUTE TABLE ────────────────────────────
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }

  tags = {
    Name = "Public_Routes"
  }
}

# associate both public subnets
resource "aws_route_table_association" "pub_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.public_rt.id
}

# ── PRIVATE ROUTE TABLE ───────────────────────────
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev_nat.id
  }

  tags = {
    Name = "Private_Routes"
  }
}

# associate both private subnets
resource "aws_route_table_association" "priv_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv_1b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = aws_route_table.private_rt.id
}