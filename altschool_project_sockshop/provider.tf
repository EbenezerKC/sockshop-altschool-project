terraform { 
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = "1e6a0ffd-ee76-43ab-971a-be7f87baf389"
}

# Replace these with your actual resource group and AKS cluster names
data "azurerm_kubernetes_cluster" "example" {
  name                = "weave-sockshop"
  resource_group_name = "sockshopdemo"
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.example.kube_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.example.kube_config[0].cluster_ca_certificate)
}

# Create a Kubernetes namespace for your app
resource "kubernetes_namespace" "kube-namespace" {
  metadata {
    name = "sock-shop"
  }
}
