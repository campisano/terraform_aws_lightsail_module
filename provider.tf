provider "aws" {
  region                  = var.aws_provider.region
  shared_credentials_file = var.aws_provider.credentials_file
  profile                 = var.aws_provider.profile
}
