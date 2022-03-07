terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.98.0"
    }
  }
  # Store Terraform state in Azure Storage
  backend "azurerm" {
    resource_group_name  = "rgkdiditfstates"
    storage_account_name = "satfstatedevops"
    container_name       = "contterraformgithubactions"
    key                  = "keyterraformgithubactions.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

# Create Resource Group
resource "azurerm_resource_group" "kdidi" {
  name     = "kdidi"
  location = "eastus2"
}