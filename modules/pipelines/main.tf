
resource "azuredevops_build_definition" "pipeline" {
  project_id = var.project_id
  name       = var.name
  path       = replace(var.path, "/", "\\")

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type   = "TfsGit"
    repo_id     = var.repository_id
    branch_name = var.default_branch
    yml_path    = join("/", [var.path, var.file_name])
  }
}
