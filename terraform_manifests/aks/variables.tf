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
  type = string
  description = "Azure Region where all these resources will be provisioned"
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


variable "acr_reg_name" {
  description = "ACR Reg"
  default = ""
}

variable "acr_reg_sku" {
  description = "ACR Reg sku"
  default = ""
}

variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = ""
}

variable "devops_repo_name" {
  description = "Azure GIT Repo"
  default = ""
}

variable "aks_cluster_name" {
  description = "Azure AKS Cluster"
  default = ""
}

variable "aks_cluster_dnprfx_name" {
  description = "Azure AKS Cluster DNS PreFix"
  default = ""
}

###NEWONES###############################################
#########################################################

# Global variables
# ------------------------------------

variable "application" {
  type    = string
  default = "aks"
}

variable "default_tags" {
  type = map
  default = {
    Project     = "trackerappaks"
    Application = "aks"
    Automate    = "terraform"
    Customer    = "all"
  }
}
data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "vault" {
  name                = "${var.devops_prj_name}-vault"
  resource_group_name = "${var.devops_prj_name}-vault"
}

# Project variables
# ------------------------------------
variable "vnet_cidr" {
  type = map
  default = {
    "dev"     = "10.1.0.0/16" 
    "stage"   = "10.2.0.0/16"
    "prod"    = "10.3.0.0/16"
  }
}

variable "aks_node_pool_cidr" {
  type = map
  default = {
    "dev"      = "10.1.0.0/17"
    "stage"    = "10.2.0.0/17"
    "prod"     = "10.3.0.0/17"
  }
}
variable "aks_max_pod_number" {
  type    = map
  default = {
    "dev"     = 100
    "stage"   = 100
    "prod"    = 100
  }
}
variable "node_count" {
  type = map
  default = {
    "dev"     = 1
    "stage"   = 1
    "prod"    = 2
  }
}
variable "node_size" {
  type = map
  default = {
    "dev"     = "standard_ds3_v2" # 4vCPUs, 14GiB
    "stage"   = "standard_ds3_v2" # 4vCPUs, 14GiB
    "prod"    = "standard_ds3_v2" # 4vCPUs, 14GiB
  }
}
variable "ssh_pub_key_secret_name" {
  type = map
  default = {
    "dev"       = "aks-dev-ssh-pub"
    "stage"     = "aks-test-ssh-pub"
    "prod"      = "aks-prod-ssh-pub"
  }
}
variable "aks_ingress_lb_ip" {
  type = map
  default = {
    "dev"    = "10.1.127.200"
    "stage"   = "10.2.127.200"
    "prod"   = "10.3.127.200"
  }
}
variable "end_date" {
  default = "2033-01-01T01:02:03Z"
}
variable "node_admin_username" {
  type    = string
  default = "ubuntu"
}

variable "vnet_name" {
  description = "vnet_name"
  default = ""
}

variable "region" {
  description = "region"
  default = ""
}

# Environment variables
# Dynamic because of workspace usage
# ------------------------------------
locals {
  environment = terraform.workspace
  stack_name  = var.vnet_name

  # Local variables prefixed with 'env_' are environment dependant
  env_tags                    = merge( var.default_tags, tomap({"Environment" = local.environment}) )

  env_vnet_cidr               = lookup(var.vnet_cidr, terraform.workspace)
  env_node_count              = lookup(var.node_count, terraform.workspace)
  env_node_size               = lookup(var.node_size, terraform.workspace)
  env_aks_node_pool_cidr      = lookup(var.aks_node_pool_cidr, terraform.workspace)
  env_aks_ingress_lb_ip       = lookup(var.aks_ingress_lb_ip, terraform.workspace)
  env_ssh_pub_key_secret_name = lookup(var.ssh_pub_key_secret_name, terraform.workspace)
  env_aks_max_pod_number      = lookup(var.aks_max_pod_number, terraform.workspace)
}


###NEWONES###############################################
#########################################################

/*
# AKS Input Variables

# SSH Public Key for Linux VMs

variable "ssh_public_key" {
  #default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

# Windows Admin Username for k8s worker nodes
variable "windows_admin_username" {
  type = string
  default = "azureuser"
  description = "This variable defines the Windows admin username k8s Worker nodes"  
}

# Windows Admin Password for k8s worker nodes
variable "windows_admin_password" {
  type = string
  default = "P@ssw0rd1234"
  description = "This variable defines the Windows admin password k8s Worker nodes"  
}
*/
