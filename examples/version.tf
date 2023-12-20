terraform {
  backend "local" {
    path = ".terraform-backend/terraform.tfstate"
  }
  required_version = ">= 1.0"
  
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "udm1-ops"
}