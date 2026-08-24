variable vpc_cidr {}
variable public_subnets {}
variable private_subnets {}
variable availability_zone {}

output "vpc_id" {
  value = aws_vpc.ZkStudiosVPC.id
}
output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets"{
  value = aws_subnet.private.*.id
}
output "public_subnets_cidr" {
  value = aws_subnet.public.*.cidr_block
}


resource "aws_vpc" "ZkStudiosVPC" {
 cidr_block=var.vpc_cidr

 tags= {
    Name= "main-vpc"
 }

}


resource "aws_internet_gateway" "igw" {
    vpc_id=aws_vpc.ZkStudiosVPC.id
    tags={
      Name="Main-Internet-Gateway"
    }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.ZkStudiosVPC.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zone[count.index]

  map_public_ip_on_launch = true  

  tags = {
    Name = "Public subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.ZkStudiosVPC.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zone[count.index]


  tags = {
    Name = "Private subnet-${count.index + 1}"
  }
}



# Route tables
resource "aws_route_table" "public-rt"{
   vpc_id=aws_vpc.ZkStudiosVPC.id

   route {
     cidr_block = "0.0.0.0/0" # Matches all IPv4 destinations; send traffic to the Internet Gateway
     gateway_id = aws_internet_gateway.igw.id
     }

    tags={
      Name="public-rt"
    }

}


resource "aws_route_table_association" "public-rt-association"{
   count = length(var.public_subnets)

   subnet_id= aws_subnet.public[count.index].id
   route_table_id=aws_route_table.public-rt.id


}

resource "aws_route_table" "private-rt"{
   vpc_id=aws_vpc.ZkStudiosVPC.id


    tags={
      Name="private-rt"
    }

}


resource "aws_route_table_association" "private-rt-association"{
   count = length(var.private_subnets)

   subnet_id= aws_subnet.private[count.index].id
   route_table_id=aws_route_table.private-rt.id


}