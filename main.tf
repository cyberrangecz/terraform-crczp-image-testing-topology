terraform {
  required_providers {
    crczp = {
      source  = "cyberrangecz/crczp"
      version = ">= 0.2.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54"
    }
  }
}

resource "openstack_images_image_v2" "test_image" {
  name             = "${var.image_name}-${var.rev}"
  local_file_path  = local._image_local_path
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "public"

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
    "owner_specified.openstack.custom"     = "true"
  }
}

resource "local_file" "topology" {
  filename = "topology.yml"
  content  = replace(file("topology.yml"), "IMAGE_NAME", openstack_images_image_v2.test_image.name)
}

resource "terraform_data" "git_branch" {
  input = {
    branch_name = "citest-${var.rev}"
    topology    = local_file.topology.content_sha256
  }
  triggers_replace = [local_file.topology]
  provisioner "local-exec" {
    command = <<EOT
    git config user.name "github-actions[bot]"
    git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
    git switch -c ${self.input.branch_name}
    git add ${local_file.topology.filename}
    git commit -m "${var.commit_message}"
    git push origin ${self.input.branch_name}
    EOT
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
    git push --delete origin ${self.input.branch_name}
    EOT
  }
}

module "sandbox" {
  source  = "cyberrangecz/sandbox/crczp"
  version = ">= 0.2.0"

  project_url         = var.project_url
  rev                 = terraform_data.git_branch.output.branch_name
  refresh_image_cache = true

  depends_on = [
    openstack_images_image_v2.test_image,
    terraform_data.git_branch
  ]
}
