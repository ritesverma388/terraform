terraform {
  backend "s3"{
    bucket = "mybucket388"
    key  = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "s3-state-lock"
  }
}
