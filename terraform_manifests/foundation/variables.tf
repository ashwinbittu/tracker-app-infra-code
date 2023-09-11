# Global variables
# ------------------------------------
variable "client_id" {
  description = "Azure Service Principal Client ID"
  default = ""
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  default = ""
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  default = ""
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  default = ""
}

variable "subscription_name" {
  description = "Azure subscription_name"
  default = ""
}

variable "devops_org_name" {
  description = "devops_org_name"
  default = ""
}

variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = ""
}

variable "org_service_url" {
  description = "org_service_url"
  default = ""
}

variable "personal_access_token" {
  description = "personal_access_token"
  default = ""
}

variable "devops_rg_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = ""
}


variable "devops_rg_location" {
  type    = string
  default = ""
}
variable "devops_prj_name" {
  type    = string
  default = ""
}
variable "application" {
  type    = string
  default = "vault"
}

variable "backend_azure_rg_name" {
  type    = string
  default = ""
}

variable "backend_azure_storgaccnt_name" {
  type    = string
  default = ""
}

variable "backend_azure_cont_name" {
  type    = string
  default = ""
}

data "azurerm_client_config" "current" {}

/*
variable "default_tags" {
  type = map
  default = {
    Project     = var.devops_prj_name
    Application = "vault"
    Automate    = "terraform"
    Customer    = "all"
  }
}
*/



# Project variables
# ------------------------------------
variable "azure_administrator_object_id" {
  type = list
  default = [
    #var.client_id,
    "45f634d0-b847-47b8-935f-2d0767dfd88c",
  ]
}

# Local variables
# ------------------------------------
locals {
  stack_name  = "${var.devops_prj_name}-${var.application}"
}
