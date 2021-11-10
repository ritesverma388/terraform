provider "aws" {
  region = "ap-south-1"
  access_key = "AKIASXHUF7BGLKLFIM5U"
  secret_key = "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"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = "${aws_vpc.myvpc.id}"
}

resource "aws_eip" "nat_eip-1"{
  vpc =true
depends_on =[aws_internet_gateway.mygateway]
}

resource "aws_eip" "nat_eip-2"{
  vpc =true
depends_on =[aws_internet_gateway.mygateway]
}



resource "aws_nat_gateway" "nat-2" {
  allocation_id = aws_eip.nat_eip-2.id
  subnet_id = aws_subnet.public-2.id
  depends_on    = [aws_internet_gateway.mygateway]
}

resource "aws_nat_gateway" "nat-1" {
  allocation_id = aws_eip.nat_eip-1.id
  subnet_id = aws_subnet.public-1.id
  depends_on    = [aws_internet_gateway.mygateway]
}

resource "aws_subnet" "public-1" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "public-2" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
}

resource "aws_subnet" "private-1" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "private-2" {
  vpc_id                  = "${aws_vpc.myvpc.id}"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"

}



resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.myvpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mygateway.id}"
}


resource "aws_route_table" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id

  route{
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat-1.id
    }
}

resource "aws_route_table_association" "private_subnet-1"{
  subnet_id = aws_subnet.private-1.id
  route_table_id = aws_route_table.private_subnet.id
}

resource "aws_route_table_association" "private_subnet-2"{
  subnet_id = aws_subnet.private-2.id
  route_table_id = aws_route_table.private_subnet.id
}
