terraform {
  backend "s3" {
    bucket = "terraformstate14328"  # bucket name
    key = "terraform/backend"       # folder path
    region = "us-east-1"            # region where s3 bucket is created
  }
}