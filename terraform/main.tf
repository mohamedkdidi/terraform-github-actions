terraform {
  # Store Terraform state in Azure Storage
  backend "azurerm" {
    resource_group_name  = "rgkdiditfstates"
    storage_account_name = "satfstatedevops"
    container_name       = "contterraformgithubactions"
    key                  = "keyterraformgithubactions.tfstate"
  }
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  # subscription_id = "..."
  # client_id       = "..."
  # client_secret   = "..."
  # tenant_id       = "..."
}

data "azurerm_client_config" "current" {}

# Create Resource Group
resource "azurerm_resource_group" "kdidi" {
  name     = "kdidi"
  location = "eastus2"
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "kdidi-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.kdidi.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.kdidi.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}

# Create a docker container
resource "docker_container" "ubuntu" {
  name  = "ubuntu-latest"
  image = docker_image.ubuntu.latest
}
  