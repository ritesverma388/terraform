resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rdsubnet"
  subnet_ids = ["${var.rds_subnet1}","${var.rds_subnet2}"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "ritesh"
  password             = "${file(rds_pass.txt)}"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = ["${var.ssh_http_Security_group}"]
  db_subnet_group_name = "${aws_db_subnet_group.rds_subnet.id}"
}
