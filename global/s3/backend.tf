terraform {
  backend "s3" {
    bucket  = "dev-tf-state"
    key     = "global/s3/terraform.state"
    region  = "ap-northeast-2"
    profile = "jongbeom"
  }
}
