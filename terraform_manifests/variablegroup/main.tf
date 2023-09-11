data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}
/*
resource "azuredevops_variable_group" "tracker_app_var_group" {
  project_id   = data.azuredevops_project.devops_project.id
  name         = "tracker_test_variable_grp"
  allow_access = true

  
  //key_vault {
  //  name                = "example-kv"
  //  service_endpoint_id = azuredevops_serviceendpoint_azurerm.azurerm_svc_endpoint.id
  //}
  
  variable {
    name = "key1"
  }

  variable {
    name = "key2"
  }
  
}

resource "azuredevops_pipeline_authorization" "tracker_app_vargrp_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_variable_group.tracker_app_var_group.id
  type        = "variablegroup"
}

*/


/*
resource "azuredevops_serviceendpoint_azurerm" "azurerm_svc_endpoint" {
  project_id            = data.azuredevops_project.devops_project.id
  service_endpoint_name         = "Example AzureRM"
  service_endpoint_authentication_scheme = "ServicePrincipal"
  azurerm_spn_tenantid          = "00000000-0000-0000-0000-000000000000"
  azurerm_subscription_id       = "00000000-0000-0000-0000-000000000000"
  azurerm_subscription_name     = "Example Subscription Name"
}
*/