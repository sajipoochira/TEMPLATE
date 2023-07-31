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
    ip_address = string
  }))

}

variable "os_image" {

}

variable "tags" {

}

variable "subscription_id" {

}

variable "vnet_rg_name" {
  
}


variable "OSType" {
  
}