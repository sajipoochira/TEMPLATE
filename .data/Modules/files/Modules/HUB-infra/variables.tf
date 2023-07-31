##  variables

variable "location" {

}

variable "tags" {

  default = {
    Environment = "Hub"

  }

}

variable "network_resource_group" {

}

variable "vnet" {

}

variable "resource_group_names" {

}

variable "network_settings" {

  type = map(object({
    subnet           = string
    address_prefixes = list(string)
    nsg              = string
    route_table      = string
  }))

}

variable "storage_account_name" {

}

variable "prefix" {

}

variable "access_key" {

}

variable "subscription_id" {
  
}