data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

resource "azuredevops_environment" "tracker_env" {
  project_id = data.azuredevops_project.devops_project.id
  name        = var.environment
}



/*
resource "azuredevops_environment" "tracker_qa_env" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "qa"
}

resource "azuredevops_pipeline_authorization" "tracker_qa_env_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_environment.tracker_qa_env.id
  type        = "environment"
}

resource "azuredevops_environment" "tracker_prod_env" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "prod"
}

resource "azuredevops_pipeline_authorization" "tracker_prod_env_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_environment.tracker_prod_env.id
  type        = "environment"
}

resource "azurerm_resource_group" "tracker_rg_dev" {
  name = "${var.devops_rg_name}_${azuredevops_environment.tracker_dev_env.name}"
  location = var.devops_rg_location
}


resource "azurerm_resource_group" "tracker_rg_qa" {
  name = "${var.devops_rg_name}_${azuredevops_environment.tracker_qa_env.name}"
  location = var.devops_rg_location
}

resource "azurerm_resource_group" "tracker_rg_prod" {
  name = "${var.devops_rg_name}_${azuredevops_environment.tracker_prod_env.name}"
  location = var.devops_rg_location
}
*/