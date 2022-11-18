
resource "azuredevops_project" "project" {
  name               = var.name
  description        = var.description
  features           = var.features
  visibility         = var.visibility
  work_item_template = var.template
}
