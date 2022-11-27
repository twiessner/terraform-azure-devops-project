<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | ./modules/service_endpoints | n/a |
| <a name="module_pools"></a> [pools](#module\_pools) | ./modules/agent_pools | n/a |
| <a name="module_project"></a> [project](#module\_project) | ./modules/project | n/a |
| <a name="module_repos"></a> [repos](#module\_repos) | ./modules/repositories | n/a |
| <a name="module_security"></a> [security](#module\_security) | ./modules/security | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pools_vmss"></a> [agent\_pools\_vmss](#input\_agent\_pools\_vmss) | Bootstrap optional agent pools, e.g. Virtual Mahine Scale Sets in your private Azure infrastructure. | <pre>map(object({<br>    # pool configuration<br>    osType              = optional(string, "linux")<br>    desiredIdle         = optional(number, 0)<br>    desiredSize         = optional(number, 1)<br>    maxCapacity         = optional(number, 3)<br>    timeToLiveMinutes   = optional(number, 45)<br>    recycleAfterEachUse = optional(bool, false)<br>    # pool meta data<br>    service_endpoint_name        = string<br>    virtual_machine_scale_set_id = string<br>  }))</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of this project. | `string` | `"Managed by Terraform."` | no |
| <a name="input_features"></a> [features](#input\_features) | Defines the status (enabled, disabled) of the all project features. | `map(string)` | <pre>{<br>  "artifacts": "enabled",<br>  "boards": "enabled",<br>  "pipelines": "enabled",<br>  "repositories": "enabled",<br>  "testplans": "disabled"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this project. | `string` | n/a | yes |
| <a name="input_repos"></a> [repos](#input\_repos) | Bootstrap optional GIT repositories incl. e.g. files, pipelines... | <pre>map(object({<br>    default_branch                  = optional(string, "refs/heads/main")<br>    default_branch_policies_enabled = optional(bool, true)<br>    # setup initial files<br>    files = optional(map(object({<br>      path    = string<br>      content = string<br>    })), {})<br>    # setup initial pipelines based on initial files<br>    pipelines = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| <a name="input_security"></a> [security](#input\_security) | Bootstrap oprional security settings for related git and project levels, e.g. RBAC. | <pre>object({<br>    rbac = optional(map(set(string)), {})<br>    git = optional(map(object({<br>      permissions = map(string)<br>    })), {})<br>    project = optional(map(object({<br>      permissions = map(string)<br>    })), {})<br>  })</pre> | <pre>{<br>  "git": {},<br>  "project": {}<br>}</pre> | no |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | Bootstrap optional service endpoints, e.g. into your private Azure infrastructure. | <pre>object({<br>    arm = map(object({<br>      client_id           = string<br>      client_secret       = string<br>      tenant_id           = string<br>      subscription_id     = string<br>      subscription_name   = string<br>      resource_group_name = optional(string)<br>    }))<br>  })</pre> | <pre>{<br>  "arm": {}<br>}</pre> | no |
| <a name="input_template"></a> [template](#input\_template) | Specifies the work item template. Valid values: Agile, Basic, CMMI, Scrum. | `string` | `"Agile"` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Specifies the visibility of this project. Valid values: private or public. | `string` | `"private"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
