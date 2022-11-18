
module "project" {
  source = "./modules/project"

  name        = var.project.name
  description = var.project.description
  features    = var.project.features
  visibility  = var.project.visibility
  template    = var.project.template
}

module "security" {
  source = "./modules/security"

  project_id = module.project.id
  rbac       = var.project.security.rbac
  git        = var.project.security.git
  project    = var.project.security.project
}

module "repos" {
  for_each = var.project.repos
  source   = "./modules/repositories"

  name       = each.key
  project_id = module.project.id
  files      = each.value.files
  pipelines  = each.value.pipelines

  default_branch                  = each.value.default_branch
  default_branch_policies_enabled = each.value.default_branch_policies_enabled
}
