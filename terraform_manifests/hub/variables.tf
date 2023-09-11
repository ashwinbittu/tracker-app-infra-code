# Global variables
# --------------------------
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

variable "org_service_url" {
  description = "org_service_url"
  default = ""
}

variable "personal_access_token" {
  description = "personal_access_token"
  default = ""
}

variable "devops_rg_location" {
  type    = string
  default = ""
}
variable "devops_rg_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = ""
}

variable "devops_prj_name" {
  description = "Azure Project"
  default = ""
}


variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = ""
}

variable "application" {
  type    = string
  default = "hub"
}
variable "default_tags" {
  type = map
  default = {
    Project     = "trackerappaks"
    Application = "hub"
    Automate    = "terraform"
    Customer    = "all"
    Environment = "common"
  }
}
variable "end_date" {
  default = "2033-01-01T01:02:03Z"
}
data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "vault" {
  name                = "${var.devops_prj_name}-vault"
  resource_group_name = "${var.devops_prj_name}-vault"
}

# Project variables
# --------------------------

# Network
variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
  # 100.0.0.0 - 100.0.255.255
}
variable "subnet_waf_cidr" {
  type    = string
  default = "10.0.0.0/22"
  # 100.0.0.0 - 100.0.3.255
}
variable "subnet_management_cidr" {
  type    = string
  default = "10.0.4.0/22"
}
# The name corresponds to both vnet name and resource group name
variable "vnet_spoke_to_peer" {
  type = list
  default = [
    "trackerappaks-aks-dev",
  ]
}
variable "aks_private_lb_ip" {
  type = map
  default = {
    "dev"       = "10.1.127.200"
    "stae"      = "10.2.127.200"
    "prod"      = "10.3.127.200"
  }
}
variable "domain" {
  type    = string
  default = "datastackapp.com"
}
variable "exposed_dns" {
  type = map
  default = {
    "app-dev" = {
      "dns"       = "dev.datastackapp.com"
      "env"       = "dev"
      "protocol"  = "Http"
    }
  }
}
variable "certificate_wildcard_name_in_vault" {
  type    = string 
  default = "wildcard-datastackapp-com"
}

# Local variables
# --------------------------
locals {
  stack_name = "${var.devops_prj_name}-${var.application}"
}
