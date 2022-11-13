
resource "azuredevops_project" "project" {
  name = var.project.name
  visibility = var.project.visibility
  work_item_template = var.project.template
  description = var.project.description
  features = var.project.features
}
