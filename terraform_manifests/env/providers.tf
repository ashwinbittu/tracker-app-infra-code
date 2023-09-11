
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




