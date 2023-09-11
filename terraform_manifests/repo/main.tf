data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

resource "azuredevops_git_repository" "devsecops_files_repo" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "devsecops_files"  #var.devops_repo_name  
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/ashwinbittu/devsecops_files.git"
  }  
  lifecycle { ignore_changes = [ initialization ] } 
}
