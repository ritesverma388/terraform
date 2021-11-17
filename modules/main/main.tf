module "mymodule" {
  source = "../networking"
}

module "ec2module" {
  source = "../ec2instances"
  vpc-id = "${module.mymodule.vpc-id}"
  public-1 = "${module.mymodule.public-1}"
  public-2 = "${module.mymodule.public-2}"

  private-1 = "${module.mymodule.private-1}"
  private-2 = "${module.mymodule.private-2}"
}

module "rds" {
  source = "../RDS"
  rds_subnet1 = "${module.mymodule.private-1}"
  rds_subnet2 = "${module.mymodule.private-2}"
  rds_vpc_id = "${module.mymodule.vpc-id}"
  ssh_http_Security_group = "${module.ec2module.aws_security_group1}"
}
