terraform {
  backend "s3" {
    bucket = "shibnath-jenkins-server"
    region = "ap-south-1"
    key = "eks/terraform.tfstate"
  }
}
