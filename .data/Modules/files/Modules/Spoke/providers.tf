terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
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
    storage_account_name = "stmcittfstatebackend"
    container_name       = "tfstate"
    key                  = "spoke.prod.terraform.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "JtIdYr9UmUt7VuVRCCxDQv+e5Py8em2ioLOZX48Y7vERHgK7vGl6ozqCf3Q8GBXeY+b2xxwnaIft+ASt08jmsA=="
  }
}
