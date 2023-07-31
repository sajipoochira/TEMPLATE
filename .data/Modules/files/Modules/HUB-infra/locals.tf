locals {
  security_rule = [
    {
      name                                       = "AllowHttpsInbound"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 120
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "Internet"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []

    },
    {
      name                                       = "AllowGatewayManagerInbound"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 130
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "GatewayManager"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowAzureLoadBalancerInbound"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 140
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "AzureLoadBalancer"
      destination_address_prefix                 = "*"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowBastionHostCommunication"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 150
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_ranges                    = ["8080", "5701"]
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowSshRdpOutbound"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 100
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_ranges                    = ["22", "3389"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowAzureCloudOutbound"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 110
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_ranges                    = ["443"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "AzureCloud"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowBastionCommunication"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 120
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_ranges                    = ["8080", "5701"]
      source_address_prefix                      = "VirtualNetwork"
      destination_address_prefix                 = "VirtualNetwork"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
    {
      name                                       = "AllowGetSessionInformation"
      description                                = "Azure Bastion Default Rule"
      priority                                   = 130
      direction                                  = "Outbound"
      access                                     = "Allow"
      protocol                                   = "*"
      source_port_range                          = "*"
      destination_port_ranges                    = ["80"]
      source_address_prefix                      = "*"
      destination_address_prefix                 = "Internet"
      destination_address_prefixes               = []
      source_address_prefixes                    = []
      destination_application_security_group_ids = []
      destination_port_range                     = ""
      source_application_security_group_ids      = []
      source_port_ranges                         = []
    },
  ]

}