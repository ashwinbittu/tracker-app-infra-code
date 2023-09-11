output "personal_access_token" {
   value = var.personal_access_token
}

output "org_service_url" {
   value = var.org_service_url
}

output "subscription_id" {
   value = var.subscription_id
}
output "client_id" {
   value = var.client_id
}

output "client_secret" {
   value = var.client_secret
}

output "tenant_id" {
   value = var.tenant_id
}

output "azurerm_kubernetes_cluster_host_apiserverurl" {
   value = nonsensitive(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].host)
}

output "azurerm_kubernetes_cluster_username" {
   value = nonsensitive(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].username)
}

output "azurerm_kubernetes_cluster_password" {
   value = nonsensitive(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].password)
}

output "azurerm_kubernetes_cluster_client_certificate" {
   value =  nonsensitive(base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate))
}

output "azurerm_kubernetes_cluster_client_key" {
   value =  nonsensitive(base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_key))
}

output "azurerm_kubernetes_cluster_client_cluster_ca_certificate" {
   value =  nonsensitive(base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config[0].cluster_ca_certificate))
}