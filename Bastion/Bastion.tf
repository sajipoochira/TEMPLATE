terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    storage_account_name = "qcazstnoctfstatebkend"
    container_name       = "tfstate"
    key                  = "bastion.hub.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key =""
  }
}

module "bastion" {
  source = "../.data/Modules/files/Modules/Bastion"

  subscription_id        = var.subscription_id
  resource_group_name    = var.resource_group_name
  vnet_name = var.vnet_name
  vnet_rg_name = var.vnet_rg_name
  bastion_name = var.bastion_name
  location = var.location
  tags = var.tags
}

