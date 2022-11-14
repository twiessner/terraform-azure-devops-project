
resource "azuredevops_project" "project" {
  name               = var.project.name
  description        = var.project.description
  features           = var.project.features
  visibility         = var.project.visibility
  work_item_template = var.project.template
}

module "permissions" {
  source = "./modules/permissions"

  project_id = azuredevops_project.project.id
  git = var.project.security.git
}

module "repos" {
  for_each = var.project.repos
  source = "./modules/repositories"

  name = each.key
  project_id = azuredevops_project.project.id
  default_branch = each.value.default_branch
}
