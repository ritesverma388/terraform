provider "aws" {
  region = "ap-south-1"

}

resource "aws_security_group" "ssh_http_Security_group" {
  name        = "terraform_example"
  description = "Used in the terraform to access instancess ssh and http"
  vpc_id      = "${var.vpc-id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_security_group" {
  name        = "terrafrm_example"
  description = "Used in the terraform to access instancess ssh and http"
  vpc_id      = "${var.vpc-id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 0
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "public-1" {
  instance_type = "t2.micro"
  ami = "ami-041d6256ed0f2061c"
  key_name = "terraform_ec2"
  subnet_id = "${var.public-1}"
  vpc_security_group_ids = ["${aws_security_group.ssh_http_Security_group.id}"]
}

resource "aws_instance" "public-2" {
  instance_type = "t2.micro"
  ami = "ami-041d6256ed0f2061c"
  key_name = "terraform_ec2"
  subnet_id = "${var.public-2}"
  vpc_security_group_ids = ["${aws_security_group.ssh_http_Security_group.id}"]
}


resource "aws_instance" "private-1" {
  instance_type = "t2.micro"
  ami = "ami-041d6256ed0f2061c"
  key_name = "terraform_ec2"
  subnet_id = "${var.private-1}"
  vpc_security_group_ids = ["${aws_security_group.private_security_group.id}"]

}

resource "aws_instance" "private-2" {
  instance_type = "t2.micro"
  ami = "ami-041d6256ed0f2061c"
  key_name = "terraform_ec2"
  subnet_id = "${var.private-2}"
  vpc_security_group_ids = ["${aws_security_group.private_security_group.id}"]

}
