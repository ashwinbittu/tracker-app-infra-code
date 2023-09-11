module "acr" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./acr"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name 
  environment              = var.environment  
  
}

module "aks" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./aks"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name 
  environment              = var.environment  
  aks_cluster_dnprfx_name  = var.aks_cluster_dnprfx_name
  aks_cluster_name         = var.aks_cluster_name
  vnet_name                = var.vnet_name 
  region                   = var.region   
}

/*
module "env" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./env"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name   
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name 
  environment              = var.environment

 
}

module "repo" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./repo"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name   
  environment              = var.environment 
  
}

module "variablegroup" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./variablegroup"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name 
  environment              = var.environment
  vnet_name                = var.vnet_name 
  region                   = var.region   
}




module "analytics" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./analytics"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name  
  environment              = var.environment 
  vnet_name                = var.vnet_name 
  region                   = var.region   
}

*/



/*


module "hub" {
  #source  = "app.terraform.io/radammcorp/launchtemplate/aws"
  source = "./hub"
  devops_rg_location       = var.devops_rg_location  
  devops_prj_name          = var.devops_prj_name
  devops_rg_name           = var.devops_rg_name    
  client_id                = var.client_id  
  client_secret            = var.client_secret
  acr_reg_name             = var.acr_reg_name  
  acr_reg_sku              = var.acr_reg_sku  
  org_service_url          = var.org_service_url
  personal_access_token    = var.personal_access_token   
  tenant_id                = var.tenant_id
  subscription_id          = var.subscription_id
  subscription_name        = var.subscription_name 
  environment              = var.environment 
  vnet_name                = var.vnet_name 
  region                   = var.region   
}


*/


/*data "terraform_remote_state" "network" {
  backend = "remote"
  config = {
    hostname = var.tf_host
    organization = var.tf_org 
    workspaces = {
      name = "${var.app_name}-${var.app_env}-${var.aws_region}-network"
    }
  }
}
*/ 


 













