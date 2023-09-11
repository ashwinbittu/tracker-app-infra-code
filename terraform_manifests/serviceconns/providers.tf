
terraform {
  required_version = "> 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }

    azuredevops = {
      source = "microsoft/azuredevops"
      version = "> 0.1.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }    
  }
   backend "azurerm" {
    #resource_group_name   = var.backend_azure_rg_name
    #storage_account_name  = var.backend_azure_storgaccnt_name
    #container_name        = var.backend_azure_cont_name
    #key                   = "terraform-custom-vnet.tfstate"
  } 

}  
  


provider "azuredevops"{
    org_service_url         = var.org_service_url
    personal_access_token   = var.personal_access_token
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

provider "azuread" {
    client_id         = var.client_id
    client_secret     = var.client_secret
    tenant_id         = var.tenant_id
}


provider "kubernetes" {
    host = data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host
    username = data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].username
    password = data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].password
    client_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate)
    client_key = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].cluster_ca_certificate)
}

