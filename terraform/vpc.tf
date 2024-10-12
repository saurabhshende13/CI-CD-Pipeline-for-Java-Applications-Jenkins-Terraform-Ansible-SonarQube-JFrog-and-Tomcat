resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "mysubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = join("", var.cidr_blocks)
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.public.id
}