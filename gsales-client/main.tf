# NOTE: ensure that you switch locals and terrafrom between environments
# I'm sure there's a better way to handle this, but for now we deal with it

# use in stage environment
locals {
  bill_to     = "Gales"
  environment = "stage"
  owner       = "webbtech"
  region      = "ca-central-1"
}
terraform {
  backend "s3" {
    bucket = "pf-stage-tf-state"
    key    = "gsales-cloudfront.tfstate"
    region = "ca-central-1"
  }
}

# use in production environment
/* locals {
  bill_to     = "Gales"
  environment = "prod"
  owner       = "webbtech"
  region      = "ca-central-1"
}
terraform {
  backend "s3" {
    bucket = "pf-prod-tf-state"
    key    = "gsales-cloudfront.tfstate"
    region = "ca-central-1"
  }
} */

provider "aws" {
  profile = "default"
  region  = local.region
}

module "cloudfront_s3_cdn" {
  source                    = "../modules/cloudfront"
  acm_certificate_arn       = var.acm_certificate_arn
  aliases                   = var.aliases
  compress                  = true
  cors_allowed_headers      = ["*"]
  # cors_allowed_headers      = ["content-type"]
  cors_allowed_methods      = ["GET", "HEAD", "POST", "PUT", "DELETE"]
  # cors_allowed_origins     = ["*.cloudposse.com"]
  # cors_allowed_origins      = ["*.pfsites.com"]
  # cors_allowed_origins      = ["*"]
  # cors_allowed_origins      = ""
  # cors_allowed_headers = ["Access-Control-Allow-Headers", "Origin", "Accept", "X-Requested-With", "Content-Type", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
  # Access-Control-Allow-Headers
  cors_expose_headers       = ["ETag"]
  custom_error_response     = var.custom_error_response
  geo_restriction_locations = var.geo_restriction_locations
  geo_restriction_type      = var.geo_restriction_type
  name                      = var.name
  namespace                 = var.namespace
  origin_force_destroy      = true
  parent_zone_id            = var.parent_zone_id
  stage                     = var.stage
  tags                      = {BillTo = "Gales", Owner = "webbtech"}
  use_regional_s3_endpoint  = true
}

# Comment out after first creating
/* resource "aws_s3_bucket_object" "index" {
  bucket       = module.cloudfront_s3_cdn.s3_bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/index.html"))
} */