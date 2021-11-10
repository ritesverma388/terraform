output "vpc-id"{
  value = "${aws_vpc.myvpc.id}"
}
output "public-1"{
  value = "${aws_subnet.public-1.id}"
}

output "public-2"{
  value = "${aws_subnet.public-2.id}"
}

output "private-1"{
  value = "${aws_subnet.private-1.id}"
}

output "private-2"{
  value = "${aws_subnet.private-2.id}"
}
