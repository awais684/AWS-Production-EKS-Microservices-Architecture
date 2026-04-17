# backend.tf (add to main project)
terraform {
  backend "s3" {
    bucket         = "terraform-state-YOUR_ACCOUNT_ID"
    key            = "production/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}