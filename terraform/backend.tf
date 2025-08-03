terraform {
  backend "azurerm" {
    resource_group_name  = "rg-adolearn-vserdiukov-tfstate"
    storage_account_name = "stadovserdiukovtfstate"
    container_name       = "tfstate"
    key                  = "validation.tfstate"
    use_msi              = false
  }
}
