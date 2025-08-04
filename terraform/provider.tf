terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  required_version = ">= 1.0.4"

  backend "azurerm" {
    # Configuration will be provided via pipeline
  }
}

provider "azurerm" {
  features {}
}
