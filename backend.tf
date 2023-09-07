terraform {
  backend "s3" {
    bucket = "terraform-state-dallisonlima"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}