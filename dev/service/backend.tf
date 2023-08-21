terraform {
  backend "s3" {
    bucket  = "dev-tf-state"
    key     = "dev/ec2.state"
    region  = "ap-northeast-2"
    profile = "jongbeom"
  }
}
