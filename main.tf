module "project" {
  source = "./modules/project"

  name        = var.name
  description = var.description
  features    = var.features
  visibility  = var.visibility
  template    = var.template
}

module "security" {
  source = "./modules/security"

  project_id = module.project.id
  rbac       = var.security.rbac
  git        = var.security.git
  project    = var.security.project
}

module "repos" {
  for_each = var.repos
  source   = "./modules/repositories"

  name       = each.key
  project_id = module.project.id
  files      = each.value.files
  pipelines  = each.value.pipelines

  default_branch                  = each.value.default_branch
  default_branch_policies_enabled = each.value.default_branch_policies_enabled
}

module "endpoints" {
  for_each = var.service_endpoints.arm
  source   = "./modules/service_endpoints"

  project_id = module.project.id
  arm        = merge(each.value, {
    name = each.key
  })
}

module "pools" {
  for_each = var.agent_pools_vmss
  source   = "./modules/agent_pools"

  name                = each.key
  osType              = each.value.osType
  desiredIdle         = each.value.desiredIdle
  desiredSize         = each.value.desiredSize
  maxCapacity         = each.value.maxCapacity
  timeToLiveMinutes   = each.value.timeToLiveMinutes
  recycleAfterEachUse = each.value.recycleAfterEachUse

  project_id                   = module.project.id
  service_endpoint_name        = each.value.service_endpoint_name
  virtual_machine_scale_set_id = each.value.virtual_machine_scale_set_id

  depends_on = [
    module.endpoints
  ]
}
