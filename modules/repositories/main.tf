
resource "azuredevops_git_repository" "repo" {
  name           = var.name
  project_id     = var.project_id
  default_branch = var.default_branch

  initialization {
    init_type = "Clean"
  }
}

resource "azuredevops_git_repository_file" "initial" {
  for_each = var.files

  branch              = var.default_branch
  content             = each.value.content
  file                = join("/", [each.value.path, each.key])
  repository_id       = azuredevops_git_repository.repo.id
  commit_message      = "Initial commit."
  overwrite_on_create = true

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}

module "pipelines" {
  for_each = var.pipelines
  source   = "../pipelines"

  name           = each.key
  file_name      = each.value
  project_id     = var.project_id
  default_branch = var.default_branch
  path           = var.files[each.value].path
  content        = var.files[each.value].content
  repository_id  = azuredevops_git_repository.repo.id
}
