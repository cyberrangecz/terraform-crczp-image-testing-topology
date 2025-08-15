terraform {
  required_providers {
    crczp = {
      source  = "cyberrangecz/crczp"
      version = ">= 0.2.0"
    }
  }
}

resource "local_file" "topology" {
  filename = "topology.yml"
  content  = replace(file("topology.yml"), "IMAGE_NAME", "${var.image_name}-${var.rev}")
}

resource "terraform_data" "git_branch" {
  input = {
    branch_name = "test-${var.rev}"
    topology    = local_file.topology.content_sha256
  }
  provisioner "local-exec" {
    command = <<EOT
    git switch -c ${self.input.branch_name}
    git add ${local_file.topology.filename}
    git commit -m "${var.commit_message}" --author "${var.commit_author}"
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
    terraform_data.git_branch
  ]
}
