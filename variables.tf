variable "image_name" {
  type        = string
  description = "First part of the name of the created image in OpenStack. Is followed by the `rev`."
}

variable "rev" {
  type        = string
  description = "Revision of the Git repository to test, included in name of created GitLab branch and OpenStack image."
}

variable "os_type" {
  type        = string
  description = "`os_type` of the created OpenStack image."
}

variable "os_distro" {
  type        = string
  description = "`os_distro` of the created OpenStack image."
}

variable "gui_access" {
  type        = bool
  description = "`owner_specified.openstack.gui_access` of the created OpenStack image."
}

variable "project_url" {
  type        = string
  description = "Url to the Git repository."
}

variable "commit_message" {
  type        = string
  description = "Commit message of the created Git commit."
  default     = "Replace IMAGE_NAME"
}

variable "image_local_path" {
  type        = string
  default     = null
  description = "The local path to the OpenStack image to be tested. Defaults to `target-qemu/{var.image_name}`."
}

locals {
  _image_local_path = var.image_local_path != null ? var.image_local_path : "target-qemu/${var.image_name}"
}
