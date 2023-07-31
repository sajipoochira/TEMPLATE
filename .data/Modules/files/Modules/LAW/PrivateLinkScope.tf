
resource "azurerm_monitor_private_link_scope" "private" {
  name                = "ampls-${var.law_name}"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
}

resource "azurerm_monitor_private_link_scoped_service" "service" {
  name                = "amplss-${var.law_name}"
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  scope_name          = azurerm_monitor_private_link_scope.private.name
  linked_resource_id  = azurerm_log_analytics_workspace.log-sec-ss-hub-qc-001.id
}

data "azurerm_subnet" "lawsubnet" {
  name                 = var.law_subnetname
  resource_group_name  = data.azurerm_resource_group.vnetresourcegroup.name
  virtual_network_name = data.azurerm_virtual_network.virtualnetwork.name
}

resource "azurerm_private_endpoint" "endpoint" {
  name                = "pe-${azurerm_monitor_private_link_scope.private.name}"
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  subnet_id           = data.azurerm_subnet.lawsubnet.id

  private_service_connection {
    name                           = "psc-${var.law_name}"
    private_connection_resource_id = azurerm_monitor_private_link_scope.private.id
    subresource_names = ["azuremonitor"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
        name = azurerm_monitor_private_link_scoped_service.service.name
        private_dns_zone_ids = data.azurerm_private_dns_zone.zones[*].id
  }
  
}

data "azurerm_private_dns_zone" "zones" {

    count = length(var.zones)
    name = var.zones[count.index]
  
}