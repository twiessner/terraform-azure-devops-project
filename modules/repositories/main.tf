
resource "azuredevops_git_repository" "repo" {
  name       = var.name
  project_id = var.project_id
  default_branch = var.default_branch

  initialization {
    init_type = "Clean"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to initialization to support importing existing repositories
      # Given that a repo now exists, either imported into terraform state or created by terraform,
      # we don't care for the configuration of initialization against the existing resource
      initialization
    ]
  }
}

resource "azuredevops_git_repository_file" "readme" {
  content       = <<EOF
    # Introduction
  EOF
  file          = "README.md"
  repository_id = azuredevops_git_repository.repo.id
  commit_message = "Initial commit."
  branch = var.default_branch

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}
