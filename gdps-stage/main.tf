locals {
  acm_certificate_arn = "arn:aws:acm:us-east-1:407205661819:certificate/4b591055-6e6d-4728-aed9-2c55d31c0c0f"
  aliases             = ["gdips-stage.pfsites.com"]
  name                = "fe"
  namespace           = "gdps"
  parent_zone_name    = "pfsites.com"
  region              = "ca-central-1"
  stage               = "stage"
}

terraform {
  backend "s3" {
    bucket = "pf-stage-tf-state"
    key    = "gdps-cloudfront.tfstate"
    region = "ca-central-1"
  }
}

provider "aws" {
  profile = "default"
  region  = local.region
}

module "cloudfront_s3_cdn" {
  # when creating this, the version used was 0.34.0
  source                    = "git::https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn.git?ref=master"
  
  acm_certificate_arn       = local.acm_certificate_arn
  aliases                   = local.aliases
  attributes                = var.attributes
  compress                  = true
  cors_allowed_headers      = ["*"]
  cors_allowed_methods      = ["GET", "HEAD", "PUT"]
  cors_allowed_origins      = ["*.pfsites.com"]
  cors_expose_headers       = ["ETag"]
  custom_error_response     = var.custom_error_response
  geo_restriction_locations = var.geo_restriction_locations
  geo_restriction_type      = var.geo_restriction_type
  name                      = local.name
  namespace                 = local.namespace
  origin_force_destroy      = true
  parent_zone_name          = local.parent_zone_name
  stage                     = local.stage
  tags                      = {BillTo = "Gales", Owner = "webbtech"}
  use_regional_s3_endpoint  = true
}

# Comment out after creating, or else ensure you deploy application after an update
resource "aws_s3_bucket_object" "index" {
  bucket       = module.cloudfront_s3_cdn.s3_bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/index.html"))
}
