resource "azurerm_resource_group" "hub" {
  name     = local.stack_name
  location = var.devops_rg_location

  tags = merge(var.default_tags)
}