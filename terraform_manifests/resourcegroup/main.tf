resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.devops_rg_name}"
  location = var.devops_rg_location

  #tags = merge(var.default_tags)
}

