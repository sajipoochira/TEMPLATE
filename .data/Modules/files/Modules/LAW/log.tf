
#Creating log analytics workspace---------------
resource "azurerm_log_analytics_workspace" "log-sec-ss-hub-qc-001" {
  name                = var.law_name
  location            = data.azurerm_resource_group.resourcegroup.location
  resource_group_name = data.azurerm_resource_group.resourcegroup.name
  sku                 = "PerGB2018"
  retention_in_days   = 120
  tags = var.tags
}