data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

resource "azurerm_container_registry" "acr_repo"  {
  name                = var.acr_reg_name
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  location            = data.azurerm_resource_group.aks_rg.location
  sku                 = var.acr_reg_sku
  admin_enabled       = true
  
  /*
  georeplications {
    location                = "Australia Central"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "Australia Southeast"
    zone_redundancy_enabled = true
    tags                    = {}
  }  
  */
}

