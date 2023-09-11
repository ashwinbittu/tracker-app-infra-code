data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}
/*
data "azurerm_kubernetes_service_versions" "current" {
  location = data.azurerm_resource_group.aks_rg.location
  include_preview = false
}
*/

data "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = data.azurerm_resource_group.aks_rg.name
  virtual_network_name = local.stack_name
}

##########NEWONES##########################
# Application and Service Principal
#resource "random_string" "password" {
#  length = 32
#}

/*
resource "azuread_application" "aks" {
  display_name               = local.stack_name
  web {
    homepage_url  = "https://${local.stack_name}"
    #logout_url    = "https://app.example.net/logout"
    #redirect_uris = ["https://app.example.net/account"]

    #implicit_grant {
    #  access_token_issuance_enabled = true
    #  id_token_issuance_enabled     = true
    #}
  }  

}
resource "azuread_service_principal" "aks" {
  application_id               = azuread_application.aks.application_id
  app_role_assignment_required = false
}
resource "azuread_service_principal_password" "aks" {
  service_principal_id = azuread_service_principal.aks.id
  #value                = random_string.password.result
  end_date             = var.end_date

  # wait 30s for server replication before attempting role assignment creation
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
resource "azurerm_role_assignment" "aks" {
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_subnet.aks.id
  principal_id         = azuread_service_principal.aks.id
}

# Assign AcrPull role to service principal
resource "azurerm_role_assignment" "acrpull_role" {
  scope                            = data.azurerm_resource_group.aks_rg.id
  role_definition_name             = "AcrPull"
  principal_id                     = azuread_service_principal.aks.id
  skip_service_principal_aad_check = true
}

*/

# Get SSH key from Azure Key Vault
/*
data "azurerm_key_vault_secret" "pub" {
  name         = local.env_ssh_pub_key_secret_name
  key_vault_id = data.azurerm_key_vault.vault.id
}
*/

##########NEWONES##########################

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  dns_prefix          = var.aks_cluster_dnprfx_name
  location            = data.azurerm_resource_group.aks_rg.location
  name                = var.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  #kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  kubernetes_version  = "1.27"
  node_resource_group = "${data.azurerm_resource_group.aks_rg.name}-nrg"


  default_node_pool {
    name       = "systempool"
    #vm_size    = "Standard_DS2_v2"
    vm_size              = local.env_node_size
    #orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    orchestrator_version  = "1.27"
    zones   = [1, 2, 3]
    enable_auto_scaling  = true
    max_count            = 2
    min_count            = 1
    os_disk_size_gb      = 30
    type                 = "VirtualMachineScaleSets"
    #vnet_subnet_id       = azurerm_subnet.aks-default.id
    vnet_subnet_id       = data.azurerm_subnet.aks.id 
    node_labels = {
      "nodepool-type"    = "system"
      "environment"      = var.environment
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }
    /*
    tags = {
      "nodepool-type"    = "system"
      "environment"      = var.environment
      "nodepoolos"       = "linux"
      "app"              = "system-apps"
    }   
    */
    tags                 = local.env_tags 
  }

  # Identity (System Assigned or Service Principal)
  identity { type = "SystemAssigned" }

  /*
  linux_profile {
    admin_username = var.node_admin_username

    ssh_key {
      key_data = data.azurerm_key_vault_secret.pub.value
    }
  }
  

  service_principal {
    client_id     = azuread_service_principal.aks.application_id
    client_secret = azuread_service_principal_password.aks.value
  }

  */



# Add On Profiles
#  addon_profile {
#    azure_policy { enabled = true }
#    oms_agent {
#      enabled                    = true
#      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
#    }
#  }

# RBAC and Azure AD Integration Block
#role_based_access_control {
#  enabled = true
#  azure_active_directory {
#    managed                = true
#    admin_group_object_ids = [azuread_group.aks_administrators.id]
#  }
#}  

# Windows Admin Profile
#windows_profile {
#  admin_username            = var.windows_admin_username
#  admin_password            = var.windows_admin_password
#}

# Linux Profile
#linux_profile {
#  admin_username = "ubuntu"
#  ssh_key {
#      key_data = file(var.ssh_public_key)
#  }
#}

# Network Profile
network_profile {
  load_balancer_sku = "standard"
  network_plugin = "azure"
}

# AKS Cluster Tags 
tags = {
  Environment = var.environment
  #tags = local.env_tags
}


}