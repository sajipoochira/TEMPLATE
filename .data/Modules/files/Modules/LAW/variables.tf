##  variables

variable "tags" {

}

variable "resource_group_name" {

}

variable "vnet_name" {

}

variable "subnetname" {

}

variable "virtual_machine" {
  type = map(object({
    name     = string
    vm_size  = string
    username = string
    password = string
  }))

}

variable "os_image" {

}


variable "vnet_rg_name" {
  
}

variable "lbname" {
  
}

variable "fipname" {
  
}

variable "backendName" {
  
}

variable "ruleName" {
  
}

variable "law_name" {
  
}

variable "law_subnetname" {
  
}

variable "zones" {
  type = list(string)
  default = ["privatelink.monitor.azure.com","privatelink.oms.opinsights.azure.com","privatelink.ods.opinsights.azure.com","privatelink.agentsvc.azure-automation.net", "privatelink.blob.core.windows.net"]
  
}