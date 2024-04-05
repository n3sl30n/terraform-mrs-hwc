terraform {
  backend "s3" {
    bucket = "terraformbucket-mrs"
    key    = "terraform.tfstate"
    region = "la-north-2"
    endpoints = {
      s3 = "https://obs.la-north-2.myhuaweicloud.com"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}