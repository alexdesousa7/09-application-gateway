#v0_1
provider "azurerm" {
  version = "=1.35.0"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "zones" {
  type    = list(string)
  default = []
}
variable "ssh-source-address" {
  type    = string
  default = "*"
}
