resource "azuredevops_branch_policy_min_reviewers" "default" {
  count = var.default_branch_policies_enabled ? 1 : 0

  enabled    = true
  blocking   = true
  project_id = var.project_id

  settings {
    reviewer_count                         = 1
    submitter_can_vote                     = false
    last_pusher_cannot_approve             = true
    on_push_reset_approved_votes           = true
    on_last_iteration_require_vote         = false
    allow_completion_with_rejects_or_waits = false

    scope {
      repository_id  = azuredevops_git_repository.repo.id
      repository_ref = var.default_branch
      match_type     = "Exact"
    }
  }

  depends_on = [
    azuredevops_git_repository_file.initial,
    module.pipelines
  ]
}
