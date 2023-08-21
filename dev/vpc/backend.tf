terraform {
  backend "s3" {
    bucket  = "dev-tf-state"
    key     = "dev/vpc.state"
    region  = "ap-northeast-2"
    profile = "jongbeom"
  }
}
