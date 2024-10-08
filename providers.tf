terraform {
  cloud {
    organization = "Lennar"
    workspaces {
      name = "azure-lz-subscription-vending"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
