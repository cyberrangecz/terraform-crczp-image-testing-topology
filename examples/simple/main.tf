terraform {
  required_providers {
    crczp = {
      source  = "cyberrangecz/crczp"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

provider "crczp" {
}

provider "openstack" {
}

variable "PROJECT_URL" {}
variable "REV" {}
variable "NAME" {}
variable "TYPE" {}
variable "DISTRO" {}
variable "GUI_ACCESS" {}

module "topology" {
  source               = "cyberrangecz/image-testing-topology/crczp"
  project_url          = var.PROJECT_URL
  rev                  = var.REV
  image_name           = var.NAME
  os_type              = var.TYPE
  os_distro            = var.DISTRO
  gui_access           = var.GUI_ACCESS
}
