# terraform-kypo-image-testing-topology

Terraform module which extends [sandbox-ci module](https://gitlab.ics.muni.cz/muni-kypo-images/terraform-kypo-sandbox-ci) to be used for testing KYPO CRP images.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | ~> 16.0.3 |
| <a name="requirement_kypo"></a> [kypo](#requirement\_kypo) | >= 0.1.0 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | ~> 1.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | ~> 16.0.3 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | ~> 1.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sandbox"></a> [sandbox](#module\_sandbox) | gitlab.ics.muni.cz/muni-kypo-images/sandbox-ci/kypo | n/a |

## Resources

| Name | Type |
|------|------|
| [gitlab_branch.gitlab_branch](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/branch) | resource |
| [local_file.topology](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.git_commit](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [openstack_images_image_v2.test_image](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/images_image_v2) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gui_access"></a> [gui\_access](#input\_gui\_access) | `owner_specified.openstack.gui_access` of the created OpenStack image. | `bool` | n/a | yes |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Short name of the image and image file in `./target-qemu`. | `string` | n/a | yes |
| <a name="input_kypo_endpoint"></a> [kypo\_endpoint](#input\_kypo\_endpoint) | Url to the KYPO CRP instance. | `string` | n/a | yes |
| <a name="input_os_distro"></a> [os\_distro](#input\_os\_distro) | `os_distro` of the created OpenStack image. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | `os_type` of the created OpenStack image. | `string` | n/a | yes |
| <a name="input_project_access_token"></a> [project\_access\_token](#input\_project\_access\_token) | Access token with write permissions to the GitLab repository. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Id of the GitLab repository to test. | `number` | n/a | yes |
| <a name="input_project_url"></a> [project\_url](#input\_project\_url) | Url to the GitLab repository without `https://`. | `string` | n/a | yes |
| <a name="input_rev"></a> [rev](#input\_rev) | Revision of the Git repository to test, included in name of created GitLab branch and OpenStack image. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pool_url"></a> [pool\_url](#output\_pool\_url) | `pool_url` output from `sandbox-ci` module. |
<!-- END_TF_DOCS -->