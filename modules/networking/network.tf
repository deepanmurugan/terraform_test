resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-VPC"
    },
  )
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.public_subnet_count
  cidr_block              = element(var.public_subnets_cidr, count.index)
  map_public_ip_on_launch = false
  tags = merge(
   {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-public-subnet-${count.index}"
    },
  )
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.private_subnet_count
  cidr_block              = element(var.private_subnets_cidr, count.index)
  map_public_ip_on_launch = false
  tags = merge(
   {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-private-subnet-${count.index}"
    },
  )
}

resource "aws_internet_gateway" "ig" {
  count  = 1
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-igw"
    },
  )
}

resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  vpc      = true
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-EIP-${count.index}"
    },
  )
}

resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-NAT-${count.index}"
    },
  )
}

# Route tables
resource "aws_route_table" "private" {
  count = length(var.availability_zones)
  vpc_id   = aws_vpc.vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-private-route-table-${count.index}"
    },
  )
}

resource "aws_route_table" "public" {
  count = length(var.availability_zones)
  vpc_id   = aws_vpc.vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "${lookup(var.default_tags, "AppName", "Provide Proper Key")}-public-route-table-${count.index}"
    },
  )
}

resource "aws_route" "public_internet_gateway" {
  count = length(var.availability_zones)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig[0].id
}

resource "aws_route" "private_nat_gateway" {
  count = length(var.availability_zones)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index) 
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
