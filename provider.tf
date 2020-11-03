provider "aws" {
  version                 = ">= 3.0"
  region                  = var.aws.region
  shared_credentials_file = var.aws.credentials_file
  profile                 = var.aws.profile
}
