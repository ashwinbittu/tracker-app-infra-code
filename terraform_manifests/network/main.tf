data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

data "azurerm_resource_group" "aks_rg" {
  name = var.devops_rg_name
}

resource "azurerm_virtual_network" "aks" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.aks_rg.location
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  address_space       = [local.env_vnet_cidr]

  tags = local.env_tags
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = data.azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = [local.env_aks_node_pool_cidr]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ContainerRegistry"]
}