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
    key    = "gdps-cloudfront.tfstate"
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