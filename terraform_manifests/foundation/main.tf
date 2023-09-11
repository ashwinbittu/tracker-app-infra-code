resource "azurerm_resource_group" "vault" {
  name     = local.stack_name
  location = var.devops_rg_location

  #tags = merge(var.default_tags)
}

resource "azurerm_key_vault" "vault" {
  name                            = local.stack_name
  location                        = var.devops_rg_location
  resource_group_name             = azurerm_resource_group.vault.name
  enabled_for_disk_encryption     = false
  enabled_for_deployment          = false
  enabled_for_template_deployment = false
  enable_rbac_authorization       = false
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false

  sku_name = "standard"
}


# Authorize Terraform to use keys, secrets and certificates
resource "azurerm_key_vault_access_policy" "tf" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  certificate_permissions = [
    "Get",
  ]

  key_permissions = [
    "Get",
    "Create",
    "Delete",
    "List",
    "Purge",
  ]

  secret_permissions = [
    "Get",
    "Set",
    "List",
    "Delete",
  ]
}

# Authorize administrator to use keys, secrets and certificates
resource "azurerm_key_vault_access_policy" "admin" {
  for_each     = toset(var.azure_administrator_object_id)
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.key

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "ManageContacts",
    "ListIssuers",
    "ManageIssuers",
    "GetIssuers",
    "SetIssuers",
    "Purge",
  ]

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge",
    "Decrypt",
    "Encrypt",
    "Sign",
    "UnwrapKey",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

####Adding these variable group access permission for future pipeline runs early on

data "azuredevops_project" "devops_project" {
  name = var.devops_prj_name
}

resource "azuredevops_environment" "tracker_env_dev" {
  project_id = data.azuredevops_project.devops_project.id
  name        = "dev"
}

resource "azuredevops_pipeline_authorization" "tracker_env_dev_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_environment.tracker_env_dev.id 
  type        = "environment"
}

resource "azuredevops_environment" "tracker_env_stage" {
  project_id = data.azuredevops_project.devops_project.id
  name        = "stage"
}

resource "azuredevops_pipeline_authorization" "tracker_env_stage_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_environment.tracker_env_stage.id 
  type        = "environment"
}

resource "azuredevops_environment" "tracker_env_prod" {
  project_id = data.azuredevops_project.devops_project.id
  name        = "prod"
}

resource "azuredevops_pipeline_authorization" "tracker_env_prod_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = azuredevops_environment.tracker_env_prod.id 
  type        = "environment"
}

data "azuredevops_variable_group" "variables_group_endpoint" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "${var.environment}_variables"
}



resource "azuredevops_pipeline_authorization" "variables_group_endpoint_auth" {
  project_id  = data.azuredevops_project.devops_project.id
  resource_id = data.azuredevops_variable_group.variables_group_endpoint.id
  type        = "variablegroup"
}

resource "azuredevops_git_repository" "devsecops_files_repo" {
  project_id = data.azuredevops_project.devops_project.id
  name       = "devsecops_files"  #var.devops_repo_name  
  initialization {
    init_type   = "Import"
    source_type = "Git"
    source_url  = "https://github.com/ashwinbittu/devsecops_files.git"
  }  
  lifecycle { ignore_changes = [ initialization ] } 
}
