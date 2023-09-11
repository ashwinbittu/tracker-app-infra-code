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
