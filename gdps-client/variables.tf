variable "acm_certificate_arn" {
  type = string
}

variable "aliases" {
  type = list(string)
}

variable "geo_restriction_locations" {
  type = list(string)
  default = ["CA", "US"]
}

variable "geo_restriction_type" {
  type = string
  default = "whitelist"
}

variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "parent_zone_id" {
  type = string
}

variable "region" {
  type = string
}

variable "stage" {
  type = string
}

variable "custom_error_response" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  type = list(object({
    error_caching_min_ttl = string
    error_code = string
    response_code = string
    response_page_path = string
  }))

  default = [
    {
      error_caching_min_ttl = "0"
      error_code = "403"
      response_code = "200"
      response_page_path = "/index.html"
    },
    {
      error_caching_min_ttl = "0"
      error_code = "404"
      response_code = "200"
      response_page_path = "/index.html"
    }
  ]
}