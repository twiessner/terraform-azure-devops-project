locals {
  project = {
    name = "internal_demo"
  }
}

module "project" {
  source = "../../"

  project = local.project
}
