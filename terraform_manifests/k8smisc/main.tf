
resource "azurerm_dns_zone" "tracker_domain" {
  name                =  var.domain_name
  resource_group_name =  data.azurerm_resource_group.aks_rg.name
}

resource "azurerm_dns_a_record" "record_app" {
  name                = "app"
  resource_group_name = data.azurerm_resource_group.aks_rg.name
  zone_name           = azurerm_dns_zone.tracker_domain.name
  ttl                 = 300
  records             = [var.istio_public_ip]
}

/*

data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

resource "azurerm_user_assigned_identity" "managed_identity_dns_zone" {
  name                = "managed-identity-dns-zone"
  location            = var.devops_rg_location
  resource_group_name = var.devops_rg_name
}

resource "azurerm_role_assignment" "assign_identity_dns_zone" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.example.object_id
}

*/

resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "3.35.4"

  values = [file("argocd.yaml")]
}


resource "helm_release" "updater" {
  name = "updater"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-image-updater"
  namespace        = "argocd"
  create_namespace = true
  version          = "0.8.4"

  values = [file("image-updater.yaml")]
}



resource "kubernetes_cluster_role" "azure-devops-deploy-role" {
  metadata {
    name = "azure-devops-deploy-role"
    labels = {
      test = "azure-devops-deploy-role"
    }
  }

  rule {
    api_groups     = ["*"]
    resources      = ["*"]
    verbs          = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "azure-devops-deploy-manager" {
  metadata {
    name      = "azure-devops-deploy-manager"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "azure-devops-deploy-role"
  }
  subject {
    kind      = "Group"
    name      = "system:serviceaccounts"
    api_group = "rbac.authorization.k8s.io"
  }
}

locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

resource "helm_release" "sonarqube" {
  name             = "sonarqube"
  repository       = "https://sonarsource.github.io/helm-chart-sonarqube"
  chart            = "sonarqube"
  namespace        = "sonarqube"
  create_namespace = true
  version          = "10.1.0+628"  


  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"

   
  }
 
  #values = [file("values/argocd.yaml")]
}

/*
resource "helm_release" "istio_base" {
  name             = "istio-base"
  repository       =  local.istio_charts_url
  chart            = "base"
  namespace        = "istio-system"
  create_namespace = true
  #version          = "10.1.0"

  set {
    name  = "defaultRevision"
    value = "default"
  }

  #values = [file("values/argocd.yaml")]
}


resource "helm_release" "istiod" {
  depends_on       = [helm_release.istio_base]
  name             = "istiod"
  namespace        = "istio-system"  
  repository       =  local.istio_charts_url
  chart            = "istiod"
  create_namespace = false
  atomic            = true
  lint              = true  
  #version          = "10.1.0"

  #values = [file("values/argocd.yaml")]
}

resource "helm_release" "istio_ingress" {
  depends_on       = [helm_release.istiod]   
  name             = "istio-ingress"
  repository       =  local.istio_charts_url
  chart            = "gateway"
  namespace        = "istio-ingress"
  create_namespace = true
  #version          = "10.1.0"

  #values = [file("values/argocd.yaml")]
}

*/



/*
resource "azuredevops_serviceendpoint_sonarqube" "trackerapp_sonarqube_endpoint" {
  depends_on            = [helm_release.sonarqube]
  project_id            = data.azuredevops_project.devops_project.id
  service_endpoint_name = "trackerapp_sonarqube_endpoint"
  url                   = "https://sonarqube.my.com"
  token                 = "0000000000000000000000000000000000000000"
  description           = "Managed by Terraform"
}

*/
