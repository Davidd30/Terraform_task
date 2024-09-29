resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "the main VPC"
    createdby = "David" 
  }
}

resource "aws_subnet" "David_Subnet" {
    vpc_id = aws_vpc.main.id
    for_each = var.subnet_cidr_blocks
    cidr_block = each.key
    availability_zone = each.value # or create another map with same keys and use each.key as argument 
    tags = {
        Type = var.subnet_types[each.key]
    }
}

resource "aws_internet_gateway" "David_IGW" {
    vpc_id = aws_vpc.main.id
}

resource "aws_eip" "David_EIP" {
  
}

resource "aws_nat_gateway" "David_Nat_GTW" {
  subnet_id     = aws_subnet.David_Subnet[var.public-subnet-key-to-nat].id
  allocation_id = aws_eip.David_EIP.id
}

resource "aws_route_table" "David_rtb_public" {
    vpc_id = aws_vpc.main.id
    
  route {
    cidr_block = var.allow_all_ipv4_cidr_blocks
    gateway_id = aws_internet_gateway.David_IGW.id
  }

  route {
    ipv6_cidr_block        = var.allow_all_ipv6_cidr_blocks
    gateway_id = aws_internet_gateway.David_IGW.id
  }

}

resource "aws_route_table" "David_rtb_private" {
    vpc_id = aws_vpc.main.id
    
  route {
    cidr_block = var.allow_all_ipv4_cidr_blocks
    gateway_id = aws_nat_gateway.David_Nat_GTW.id
  }
}

resource "aws_route_table_association" "David_rtb_assoc_public" {
  subnet_id      = aws_subnet.David_Subnet[each.value].id
  route_table_id = aws_route_table.David_rtb_public.id
  for_each = toset(var.keys-of-public-subnets)
}

resource "aws_route_table_association" "David_rtb_assoc_private" {
  subnet_id      = aws_subnet.David_Subnet[each.value].id
  route_table_id = aws_route_table.David_rtb_private.id
  for_each = toset(var.keys-of-private-subnets)
}