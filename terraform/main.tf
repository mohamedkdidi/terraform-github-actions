terraform {
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
resource "azurerm_resource_group" "rsgroup" {
  name     = "kdidi-resource-group"
  location = "eastus2"
}

# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "kdidi-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rsgroup.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "kdidi-subnet"
  resource_group_name  = azurerm_resource_group.rsgroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}

# Create a docker container
resource "azurerm_container_group" "container" {
  name                = "example-continst"
  location            = azurerm_resource_group.rsgroup.location
  resource_group_name = azurerm_resource_group.rsgroup.name
  ip_address_type     = "public"
  dns_name_label      = "aci-label"
  os_type             = "Linux"

  container {
    name   = "hello-world"
    image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  container {
    name   = "sidecar"
    image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "testing"
  }
}
