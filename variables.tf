variable "image_name" {
  type        = string
  description = "First part of the name of the created image in OpenStack. Is followed by the `rev`."
}

variable "rev" {
  type        = string
  description = "Revision of the Git repository to test, included in name of created GitLab branch and OpenStack image."
}

variable "project_url" {
  type        = string
  description = "Url to the Git repository."
}

variable "commit_author" {
  type        = string
  description = "Commit author of the created Git commit, in form `A U Thor <author@example.com>`."
  default     = "Terraform <ci@example.com>"
}

variable "commit_message" {
  type        = string
  description = "Commit message of the created Git commit."
  default     = "Replace IMAGE_NAME"
}
