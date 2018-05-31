variable "aws_region" {}

provider "aws" {
  region = "${var.aws_region}"
}

terraform {
    backend "s3" {
        bucket = "mozilla-iam-infra"
        key    = "network/terraform.tfstate"
        region = "us-west-2"
    }
}
