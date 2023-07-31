############################################
data "azurerm_resource_group" "resourcegroup" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "Key" {
  name                        = var.kv_name
  location                    = data.azurerm_resource_group.resourcegroup.location
  resource_group_name         = data.azurerm_resource_group.resourcegroup.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  contact {
    email = var.email
  }
  tags                            = var.tags
  enabled_for_deployment          = true
  enabled_for_template_deployment = true


  sku_name = "standard"
  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
          ip_rules                   = [
               "37.186.47.162/32",
            ]
         virtual_network_subnet_ids = [
              
            ]

  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.object_id

    certificate_permissions = [
      "Get",
      "List",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "ManageContacts",
      "ManageIssuers",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
      "Purge",
    ]
    key_permissions = [
      "Get",

      "List",
      "Purge",
      "Update",
      "Create",
      "Import",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Sign",
      "Encrypt",
      "Decrypt",
      "UnwrapKey",
      "Verify",
      "WrapKey",





    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Purge",
    ]
  }
}
data "azurerm_resource_group" "vnetresourcegroup" {
  name = var.vnet_rg_name
}

data "azurerm_virtual_network" "virtualnetwork" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnetresourcegroup.name
}



data "azurerm_subnet" "keysubnet" {
  name                 = var.kv_subnetname
  resource_group_name  = data.azurerm_resource_group.vnetresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.virtualnetwork.name
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = "pe-${azurerm_key_vault.Key.name}"
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  subnet_id           = data.azurerm_subnet.keysubnet.id

  private_service_connection {
    name                           = "psc-${var.kv_name}"
    private_connection_resource_id = azurerm_key_vault.Key.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_key_vault.Key.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.zone.id]
  }
  tags = var.tags

}

data "azurerm_private_dns_zone" "zone" {

  name = var.dnszone

}