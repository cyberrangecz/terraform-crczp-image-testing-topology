terraform {
  required_providers {
    crczp = {
      source  = "cyberrangecz/crczp"
    }
  }
}

provider "crczp" {
}

variable "PROJECT_URL" {}
variable "REV" {}
variable "NAME" {}

module "topology" {
  source               = "cyberrangecz/image-testing-topology/crczp"
  project_url          = var.PROJECT_URL
  rev                  = var.REV
  image_name           = var.NAME
}
