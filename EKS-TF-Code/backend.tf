terraform {
  backend "s3" {
    bucket         = "bkletch-tetris-eu-west-2"
    key            = "bkletch-tetris-eu-west-2/terraform/state/terraform.tfstate"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
    region         = "eu-west-2"
  }
  required_version = ">=0.13.0"
}
