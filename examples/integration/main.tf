data "azurerm_virtual_machine_scale_set" "default" {
  name                = var.vmss_name
  resource_group_name = var.vmss_resource_group_name
}

locals {
  project = {
    name              = "Integration"
    service_endpoints = {
      arm = {
        devops = {
          client_id         = var.client_id
          client_secret     = var.client_secret
          tenant_id         = var.tenant_id
          subscription_id   = var.subscription_id
          subscription_name = var.subscription_name
        }
      }
    }
  }
}

module "projects" {
  source = "../../"

  name             = local.project.name
  agent_pools_vmss = {
    default-pool-1 = {
      desiredIdle                  = 1
      service_endpoint_name        = "devops"
      virtual_machine_scale_set_id = data.azurerm_virtual_machine_scale_set.default.id
    }
  }
  service_endpoints = local.project.service_endpoints
}
