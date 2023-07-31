resource "azurerm_policy_definition" "vnetpeering" {
  name         = "Deny VNET Peering"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny VNET Peering"

  management_group_name = var.management_group_names["lab"]
  metadata = jsonencode(
    {
      alzCloudEnvironments = [
        "AzureCloud",
        "AzureChinaCloud",
        "AzureUSGovernment",
      ]
      category  = "Network"
      updatedBy = null
      updatedOn = null
      version   = "1.0.1"
    }
  )


  parameters = jsonencode(
    {
      effect = {
        allowedValues = [
          "Audit",
          "Deny",
          "Disabled",
        ]
        defaultValue = "Deny"
        metadata = {
          description = "Enable or disable the execution of the policy"
          displayName = "Effect"
        }
        type = "String"
      }
    }
  )
  policy_rule = jsonencode(
    {
      if = {
        equals = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings"
        field  = "type"
      }
      then = {
        effect = "[parameters('effect')]"
      }
    }
  )
}


resource "azurerm_policy_set_definition" "qatarpolicy" {
  name                  = "Azure Qatar Policy -Prod"
  policy_type           = "Custom"
  display_name          = "Azure Qatar Policy -Prod"
  management_group_name = var.management_group_names["production"]


  policy_definition_reference {

    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

    reference_id = "Allowed locations_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"

    reference_id = "Audit VMs that do not use managed disks_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"

    reference_id = "Storage accounts should have infrastructure encryption_1"
  }
  policy_definition_reference {
    parameter_values = jsonencode(
      {
        listOfResourceTypes = {
          value = [
            "microsoft.compute/virtualmachines",
          ]
        }
      }
    )
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7f89b1eb-583c-429a-8828-af049802c1d9"

    reference_id = "Audit diagnostic setting_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"

    reference_id = "Secure transfer to storage accounts should be enabled_1"
  }


  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e71308d3-144b-4262-b144-efdc3cc90517"

    reference_id = "Subnets should be associated with a Network Security Group_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a70ca396-0a34-413a-88e1-b956c1e683be"

    reference_id = "Virtual machines should have the Log Analytics extension installed_1"
  }


  policy_definition_reference {
    parameter_values = jsonencode(
      {
        tagName = {
          value = "Environment"
        }
      }
    )
    #,"Application","CreatedBy", "CreatedOn", "Owner"]
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
    reference_id         = "Require a tag on resources_1"
  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8405fdab-1faf-48aa-b702-999c9c172094"

    reference_id = "Managed disks should disable public network access_1"
  }



  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"

    reference_id = "Network interfaces should not have public IPs_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b5ef780-c53c-4a64-87f3-bb9c8c8094ba"

    reference_id = "App Service apps should disable public network access_1"
  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/687aa49d-0982-40f8-bf6b-66d1da97a04b"

    reference_id = "App Service apps should use private link_1"
  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780"

    reference_id = "Public network access on Azure SQL Database should be disabled_1"

  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7595c971-233d-4bcf-bd18-596129188c49"

    reference_id = "Private endpoint should be enabled for MySQL servers_1"

  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d9844e8a-1437-4aeb-a32c-0c992f056095"

    reference_id = "Public network access should be disabled for MySQL servers_1"

  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9299215-ae47-4f50-9c54-8a392f68a052"

    reference_id = "Public network access should be disabled for MySQL flexible servers_1"

  }



  policy_definition_reference {


    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"

    reference_id = "Allowed locations for resource groups_1"
  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1afdc4b6-581a-45fb-b630-f1e6051e3e7a"


    reference_id = "Linux virtual machines should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/15fdbc87-8a47-4ee9-a2aa-9a2ea1f37554"


    reference_id = "Log Analytics agent should be installed on your Cloud Services (extended support) role instances_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1ec9c2c2-6d64-656d-6465-3ec3309b8579"


    reference_id = "[Preview]: Deploy Microsoft Defender for Endpoint agent on Windows virtual machines_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/32ade945-311e-4249-b8a4-a549924234d7"


    reference_id = "Linux virtual machine scale sets should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a4fe33eb-e377-4efb-ab31-0784311bc499"


    reference_id = "Log Analytics agent should be installed on your virtual machine for Azure Security Center monitoring_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c02729e5-e5e7-4458-97fa-2b5ad0661f28"


    reference_id = "Windows virtual machines should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
    reference_id         = "Azure Backup should be enabled for Virtual Machines_1"
  }

}


resource "azurerm_policy_set_definition" "qatarpolicy-nonprod" {
  name         = "Azure Qatar Policy -NonProd"
  policy_type  = "Custom"
  display_name = "Azure Qatar Policy -NonProd"

  management_group_name = var.management_group_names["non-production"]


  policy_definition_reference {


    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

    reference_id = "Allowed locations_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"

    reference_id = "Audit VMs that do not use managed disks_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"

    reference_id = "Storage accounts should have infrastructure encryption_1"
  }
  policy_definition_reference {
    parameter_values = jsonencode(
      {
        listOfResourceTypes = {
          value = [
            "microsoft.compute/virtualmachines",
          ]
        }
      }
    )
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7f89b1eb-583c-429a-8828-af049802c1d9"

    reference_id = "Audit diagnostic setting_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"

    reference_id = "Secure transfer to storage accounts should be enabled_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e71308d3-144b-4262-b144-efdc3cc90517"

    reference_id = "Subnets should be associated with a Network Security Group_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a70ca396-0a34-413a-88e1-b956c1e683be"

    reference_id = "Virtual machines should have the Log Analytics extension installed_1"
  }


  policy_definition_reference {
    parameter_values = jsonencode(
      {
        tagName = {
          #  value = ["Environment", "Application", "CreatedBy", "CreatedOn", "Owner"]
          value = "Environment"
        }
      }
    )

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
    reference_id         = "Require a tag on resources_1"
  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8405fdab-1faf-48aa-b702-999c9c172094"

    reference_id = "Managed disks should disable public network access_1"
  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/83a86a26-fd1f-447c-b59d-e51f44264114"

    reference_id = "Network interfaces should not have public IPs_1"
  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/687aa49d-0982-40f8-bf6b-66d1da97a04b"

    reference_id = "App Service apps should use private link_1"
  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780"

    reference_id = "Public network access on Azure SQL Database should be disabled_1"

  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7595c971-233d-4bcf-bd18-596129188c49"

    reference_id = "Private endpoint should be enabled for MySQL servers_1"

  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d9844e8a-1437-4aeb-a32c-0c992f056095"

    reference_id = "Public network access should be disabled for MySQL servers_1"

  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9299215-ae47-4f50-9c54-8a392f68a052"

    reference_id = "Public network access should be disabled for MySQL flexible servers_1"

  }
  policy_definition_reference {

    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"

    reference_id = "Allowed locations for resource groups_1"
  }


  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1afdc4b6-581a-45fb-b630-f1e6051e3e7a"


    reference_id = "Linux virtual machines should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/15fdbc87-8a47-4ee9-a2aa-9a2ea1f37554"


    reference_id = "Log Analytics agent should be installed on your Cloud Services (extended support) role instances_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1ec9c2c2-6d64-656d-6465-3ec3309b8579"


    reference_id = "[Preview]: Deploy Microsoft Defender for Endpoint agent on Windows virtual machines_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/32ade945-311e-4249-b8a4-a549924234d7"


    reference_id = "Linux virtual machine scale sets should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a4fe33eb-e377-4efb-ab31-0784311bc499"


    reference_id = "Log Analytics agent should be installed on your virtual machine for Azure Security Center monitoring_1"
  }
  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c02729e5-e5e7-4458-97fa-2b5ad0661f28"


    reference_id = "Windows virtual machines should have Azure Monitor Agent installed_1"
  }
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/013e242c-8828-4970-87b3-ab247555486d"
    reference_id         = "Azure Backup should be enabled for Virtual Machines_1"
  }

}



resource "azurerm_policy_set_definition" "qatarpolicy-Lab" {
  name                  = "Azure Qatar Policy -Lab"
  policy_type           = "Custom"
  display_name          = "Azure Qatar Policy -Lab"
  management_group_name = var.management_group_names["lab"]

  policy_definition_reference {

    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

    reference_id = "Allowed locations_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"

    reference_id = "Audit VMs that do not use managed disks_1"
  }
  policy_definition_reference {


    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"

    reference_id = "Storage accounts should have infrastructure encryption_1"
  }

  policy_definition_reference {


    policy_definition_id = azurerm_policy_definition.vnetpeering.id

    reference_id = "Deny VNET Peering_1"
  }

  policy_definition_reference {

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"

    reference_id = "Storage accounts should have infrastructure encryption_2"
  }
  policy_definition_reference {

    parameter_values = jsonencode(
      {
        listOfAllowedLocations = {
          value = [
            "qatarcentral",
            "westeurope",
          ]
        }
      }
    )

    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"

    reference_id = "Allowed locations for resource groups_1"
  }

}


resource "azurerm_management_group_policy_assignment" "prod" {
  name                 = "Azure-Qatar-Prod"
  management_group_id  = data.azurerm_management_group.prod.id
  policy_definition_id = azurerm_policy_set_definition.qatarpolicy.id
  location             = var.location
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_management_group_policy_assignment" "iso-prod" {
  name                 = "ISO 27001-2013-Prod"
  management_group_id  = data.azurerm_management_group.prod.id
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/89c6cddc-1c73-4ac1-b19c-54d1a15a42f2"
  location             = var.location
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_management_group_policy_assignment" "iso-nonprod" {
  name                 = "ISO 27001-2013-NonProd"
  management_group_id  = data.azurerm_management_group.nonprod.id
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/89c6cddc-1c73-4ac1-b19c-54d1a15a42f2"
  location             = var.location
  identity {
    type = "SystemAssigned"
  }
}



resource "azurerm_management_group_policy_assignment" "nonprod" {
  name                 = "Azure-Qatar-NonProd"
  management_group_id  = data.azurerm_management_group.nonprod.id
  policy_definition_id = azurerm_policy_set_definition.qatarpolicy-nonprod.id
  location             = var.location
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_management_group_policy_assignment" "lab" {
  name                 = "Azure-Qatar-Lab"
  management_group_id  = data.azurerm_management_group.lab.id
  policy_definition_id = azurerm_policy_set_definition.qatarpolicy-Lab.id
  location             = var.location
  identity {
    type = "SystemAssigned"
  }
}


data "azurerm_management_group" "prod" {
  name = var.management_group_names["production"]
}

data "azurerm_management_group" "nonprod" {
  name = var.management_group_names["non-production"]
}

data "azurerm_management_group" "lab" {
  name = var.management_group_names["lab"]
}

