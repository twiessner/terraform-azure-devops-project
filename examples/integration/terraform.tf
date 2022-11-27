terraform {
  required_version = "~> 1.3"

  required_providers {
    shell = {
      source  = "scottwinkler/shell"
      version = "~> 1.7"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 0.3"
    }
  }
}
