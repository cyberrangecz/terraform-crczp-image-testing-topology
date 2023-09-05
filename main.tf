terraform {
  required_providers {
    kypo = {
      source  = "vydrazde/kypo"
      version = ">= 0.1.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.48.0"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.0.3"
    }
  }
}

resource "openstack_images_image_v2" "test_image" {
  name             = "${var.image_name}-${var.rev}"
  local_file_path  = "target-qemu/${var.image_name}"
  container_format = "bare"
  disk_format      = "raw"

  properties = {
    hw_scsi_model                          = "virtio-scsi"
    hw_disk_bus                            = "scsi"
    hw_rng_model                           = "virtio"
    hw_qemu_guest_agent                    = "yes"
    os_require_quiesce                     = "yes"
    os_type                                = var.os_type
    os_distro                              = var.os_distro
    "owner_specified.openstack.version"    = var.rev
    "owner_specified.openstack.gui_access" = var.gui_access
    "owner_specified.openstack.created_by" = "munikypo"
  }

  lifecycle {
    replace_triggered_by = [
      gitlab_branch.gitlab_branch
    ]
  }
}

resource "local_file" "topology" {
  filename = "topology.yml"
  content  = replace(file("topology.yml"), "IMAGE_NAME", openstack_images_image_v2.test_image.name)
}

resource "gitlab_branch" "gitlab_branch" {
  name    = "test-${var.rev}"
  ref     = var.rev
  project = var.project_id
}

resource "null_resource" "git_commit" {
  provisioner "local-exec" {
    command = <<EOT
      git config user.name "Service KYPO Images"; git config user.email "485514@muni.cz"
      git fetch
      git switch ${gitlab_branch.gitlab_branch.name}
      git add ${local_file.topology.filename}
      git commit -m "Replace IMAGE_NAME"
      git push https://root:${var.project_access_token}@${var.project_url}.git ${gitlab_branch.gitlab_branch.name}
    EOT
  }

  triggers = {
    topology      = local_file.topology.content_sha256
    gitlab_branch = gitlab_branch.gitlab_branch.name
  }
}

module "sandbox" {
  source        = "gitlab.ics.muni.cz/muni-kypo-images/sandbox-ci/kypo"
  project_url   = var.project_url
  rev           = gitlab_branch.gitlab_branch.name
  kypo_endpoint = var.kypo_endpoint

  depends_on = [
    openstack_images_image_v2.test_image,
    null_resource.git_commit
  ]
}
