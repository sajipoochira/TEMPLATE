#Subscription ID
subscription_id = ""

resource_group_name = ""

vnet_name = ""

#Create Backend  Deatails
/*

az group create --name rg-st-tfstate-qc-001 --location qatarcentral
az storage account create -n stmcittfstatebkendnet -g rg-st-tfstate-qc-001 -l qatarcentral --sku Standard_LRS
az storage container create -n tfstate --account-name stmcittfstatebkendnet
az storage account keys list --account-name stmcittfstatebkendnet

*/

tags = {
  Environment = "MCIT-GOVSS-Hub"
  CreatedBy   = "MCIT-NetworkTeam"
  CreatedOn   = "16-01-2023"
  Owner       = "acadiri@mcit.gov.qa"
  
}

location = "qatarcentral"
bastion_name = "bastion-hub-qc-001"