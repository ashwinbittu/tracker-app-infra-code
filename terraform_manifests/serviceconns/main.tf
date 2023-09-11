data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.aks_rg.name
}

/*
data "terraform_remote_state" "tracker_env" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.backend_azure_rg_name
    storage_account_name = var.backend_azure_storgaccnt_name
    container_name       = var.backend_azure_cont_name
    key                  = "${var.environment}/aks/trackerapp-azure-${var.environment}.tfstateenv:${var.environment}"                      
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id
    use_msi              = true 
  }
}
*/

data "azuredevops_git_repository" "devsecops_files_repo" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "devsecops_files"
}

data "azurerm_container_registry" "acr_repo" {
  name                = var.acr_reg_name
  resource_group_name = data.azurerm_resource_group.aks_rg.name
}

resource "azuredevops_serviceendpoint_generic_git" "proj_azgitrepo_endpoint" {
  project_id            = data.azuredevops_project.devops_project.id
  repository_url        = data.azuredevops_git_repository.devsecops_files_repo.remote_url
  service_endpoint_name = "${var.devops_prj_name}-devsecops-files-repo-endpoint-${var.environment}-${var.region}"
  enable_pipelines_access = true
}

resource "azuredevops_pipeline_authorization" "proj_git_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_serviceendpoint_generic_git.proj_azgitrepo_endpoint.id
  type        = "endpoint"
}



resource "azuredevops_serviceendpoint_azurecr" "proj_acr_endpoint" {
  project_id                = data.azuredevops_project.devops_project.id
  resource_group            = data.azurerm_resource_group.aks_rg.name
  azurecr_spn_tenantid      = var.tenant_id
  azurecr_name              = var.acr_reg_name
  azurecr_subscription_id   = var.subscription_id
  azurecr_subscription_name = var.subscription_name
  service_endpoint_name     = var.acr_endpoint
}

resource "azurerm_role_assignment" "acrpull_role" {
  principal_id                     = data.azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
  #role_definition_name             = "Owner"
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr_repo.id
  skip_service_principal_aad_check = true  
}

resource "azuredevops_pipeline_authorization" "proj_acr_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_serviceendpoint_azurecr.proj_acr_endpoint.id
  type        = "endpoint"
}

resource "azuredevops_serviceendpoint_kubernetes" "proj_aks_endpoint" {
  project_id            = data.azuredevops_project.devops_project.id
  service_endpoint_name = var.aks_endpoint
  apiserver_url         = data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
  authorization_type    = "AzureSubscription"

  azure_subscription {
    subscription_id   = var.subscription_id
    subscription_name = var.subscription_name
    tenant_id         = var.tenant_id
    resourcegroup_id  = data.azurerm_resource_group.aks_rg.name  
    namespace         = "default"
    cluster_name      = var.aks_cluster_name
  }

}

resource "azuredevops_pipeline_authorization" "proj_aks_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_serviceendpoint_kubernetes.proj_aks_endpoint.id
  type        = "endpoint"
}











/*
resource "azurerm_role_assignment" "aks_cluster_acr_push_conn" {
  principal_id                     = data.azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
  #role_definition_name             = "Owner"
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr_repo.id
  skip_service_principal_aad_check = true  
}


resource "azuredevops_serviceendpoint_argocd" "tracker_app_argocd_endpoint" {
  project_id            = data.azuredevops_project.devops_project.id
  service_endpoint_name = "${var.devops_prj_name}-${var.eks_cluster_name}_argocd_endpoint"
  description           = "Managed by Terraform"
  url                   = "https://argocd.my.com"
  authentication_token {
    token = "0000000000000000000000000000000000000000"
  }
}

resource "azuredevops_pipeline_authorization" "tracker_app_argocd_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_serviceendpoint_argocd.tracker_app_argocd_endpoint.id
  type        = "endpoint"
}

*/
