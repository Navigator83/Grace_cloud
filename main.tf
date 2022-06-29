#Creating aws network for a project

resource "aws_vpc" "Grace_work" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Grace_work"
  }
}

#Prod -pub-sub1

resource "aws_subnet" "prod-pub-sub1" {
  vpc_id     = aws_vpc.Grace_work.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "prod-pub-sub1"
  }
}

#Prod -pub-sub2

resource "aws_subnet" "prod-pub-sub2"  {
  vpc_id     = aws_vpc.Grace_work.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name =  "prod-pub-sub2"
  }
}

#Prod -pub-sub3

resource  "aws_subnet" "prod-pub-sub3" {
  vpc_id     = aws_vpc.Grace_work.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "prod-pub-sub3"
  }
}

#Prod-priv-sub1

resource "aws_subnet" "prod-priv-sub1" {
  vpc_id     = aws_vpc.Grace_work.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "prod-priv-sub1"
  }
}

#Prod-priv-sub2

resource "aws_subnet" "prod-priv-sub2" {
  vpc_id     = aws_vpc.Grace_work.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "prod-priv-sub2"
  }
}

#prod-pub-route-table

resource "aws_route_table" "prod-pub-table" {
  vpc_id = aws_vpc.Grace_work.id


  tags = {
    Name = "prod-pub-table"
  }
}

#prod-priv-route-table

resource "aws_route_table" "prod-priv-table" {
  vpc_id = aws_vpc.Grace_work.id


  tags = {
    Name = "prod-priv-table"
  }
}

#prod-Pub-Sub-association

resource "aws_route_table_association" "Grace-associa1" {
  subnet_id      = aws_subnet.prod-pub-sub1.id
  route_table_id = aws_route_table.prod-pub-table.id
}

resource "aws_route_table_association" "Grace-associa2" {
  subnet_id      = aws_subnet.prod-pub-sub2.id
  route_table_id = aws_route_table.prod-pub-table.id
}


resource "aws_route_table_association" "Grace-associa3" {
  subnet_id      = aws_subnet.prod-pub-sub3.id
  route_table_id = aws_route_table.prod-pub-table.id
}



#Prod-work-priv-association

resource "aws_route_table_association" "prod-priv-associa_route-tab1" {
  subnet_id      = aws_subnet.prod-priv-sub1.id
  route_table_id = aws_route_table.prod-priv-table.id
}

resource "aws_route_table_association" "prod-priv-associa_route-tab2" {
  subnet_id      = aws_subnet.prod-priv-sub2.id
  route_table_id = aws_route_table.prod-priv-table.id
}




#Prod-igw
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Grace_work.id

  tags = {
    Name = "Prod-igw"
  }
}

#Prod-igw-association with public route table


resource "aws_route" "prod-IGW-association" {
  route_table_id         = aws_route_table.prod-pub-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.Prod-igw.id
}

#Elastic IP for Nat Gateway

resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    Name = "Nat Gateway EIP"
  }
}

#Prod-Nat-gateway
#terraform create Nat Gateway in priv-subnet
resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.prod-pub-sub1.id

  tags = {
    Name = "Nat_gateway"
  }
}

#Association with NAT gateway with prive 

resource "aws_route" "prod_NGW" {
  route_table_id   = aws_route_table.prod-priv-table.id
  gateway_id       = aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block = "0.0.0.0/0"
}


