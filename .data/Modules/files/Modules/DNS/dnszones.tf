locals {
  dnszones = {
    zn1 = { name = "privatelink.azurewebsites.net"},
    zn2 = { name = "privatelink.blob.core.windows.net"},
    zn3 = { name = "privatelink.database.windows.net"},
    zn4 = { name = "privatelink.file.core.windows.net"},
    zn5 = { name = "privatelink.monitor.azure.com"},
    zn6 = { name = "privatelink.ods.opinsights.azure.com"},
    zn7 = { name = "privatelink.oms.opinsights.azure.com"},
    zn8 = { name = "privatelink.redis.cache.windows.net"},
    zn9 = { name = "privatelink.vaultcore.azure.net"}
    zn10 = { name = "privatelink.agentsvc.azure-automation.net"}
    }
}


resource "azurerm_private_dns_zone" "dnszone" {
    for_each = local.dnszones
  name                = each.value["name"]
  resource_group_name = data.azurerm_resource_group.vnetresourcegroup.name
  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
    for_each = local.dnszones
  name                  = "link-${each.value["name"]}-${var.vnet_name}"
  resource_group_name   = data.azurerm_resource_group.vnetresourcegroup.name
  private_dns_zone_name = azurerm_private_dns_zone.dnszone[each.key].name
  virtual_network_id    = data.azurerm_virtual_network.virtualnetwork.id
}