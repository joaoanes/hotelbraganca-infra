terraform {
  backend "s3" {
    bucket = "mc-terraform-backend"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
