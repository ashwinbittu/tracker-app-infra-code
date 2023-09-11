data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

resource "random_pet" "aksrandom" {}

resource "azurerm_log_analytics_workspace" "insights" {
  name                = "${var.environment}-logs-${random_pet.aksrandom.id}"
  location            = data.azurerm_resource_group.aks_rg.location
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  retention_in_days   = 30
}