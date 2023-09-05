variable "kypo_endpoint" {
  type        = string
  description = "Url to the KYPO CRP instance."
}

variable "image_name" {
  type        = string
  description = "Short name of the image and image file in `./target-qemu`."
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

variable "project_id" {
  type        = number
  description = "Id of the GitLab repository to test."
}

variable "project_url" {
  type        = string
  description = "Url to the GitLab repository without `https://`."
}

variable "project_access_token" {
  type        = string
  description = "Access token with write permissions to the GitLab repository."
  sensitive   = true
}
