# terraform-kypo-image-testing-topology

Terraform module which extends [sandbox module](https://github.com/cyberrangecz/terraform-crczp-sandbox) to be used for testing CRCZP images.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_crczp"></a> [crczp](#requirement\_crczp) | >= 0.2.0 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | ~> 1.54 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | ~> 1.54 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sandbox"></a> [sandbox](#module\_sandbox) | cyberrangecz/sandbox/crczp | >= 0.2.0 |

## Resources

| Name | Type |
|------|------|
| [local_file.topology](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [openstack_images_image_v2.test_image](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/images_image_v2) | resource |
| [terraform_data.git_branch](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_commit_author"></a> [commit\_author](#input\_commit\_author) | Commit author of the created Git commit, in form `A U Thor <author@example.com>`. | `string` | `"Terraform <ci@example.com>"` | no |
| <a name="input_commit_message"></a> [commit\_message](#input\_commit\_message) | Commit message of the created Git commit. | `string` | `"Replace IMAGE_NAME"` | no |
| <a name="input_gui_access"></a> [gui\_access](#input\_gui\_access) | `owner_specified.openstack.gui_access` of the created OpenStack image. | `bool` | n/a | yes |
| <a name="input_image_local_path"></a> [image\_local\_path](#input\_image\_local\_path) | The local path to the OpenStack image to be tested. Defaults to `target-qemu/{var.image_name}`. | `string` | `null` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | First part of the name of the created image in OpenStack. Is followed by the `rev`. | `string` | n/a | yes |
| <a name="input_os_distro"></a> [os\_distro](#input\_os\_distro) | `os_distro` of the created OpenStack image. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | `os_type` of the created OpenStack image. | `string` | n/a | yes |
| <a name="input_project_url"></a> [project\_url](#input\_project\_url) | Url to the Git repository. | `string` | n/a | yes |
| <a name="input_rev"></a> [rev](#input\_rev) | Revision of the Git repository to test, included in name of created GitLab branch and OpenStack image. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

**Author**: Zdeněk Vydra
