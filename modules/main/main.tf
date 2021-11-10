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
