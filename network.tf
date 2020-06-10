#v0_1
resource "azurerm_virtual_network" "testag" {
  name                = "testag-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.testag.name
  #address_space       = ["10.0.0.0/16"]
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_subnet" "testag-subnet-1" {
  name                 = "testag-subnet-1"
  resource_group_name  = azurerm_resource_group.testag.name
  virtual_network_name = azurerm_virtual_network.testag.name
  #address_prefix       = "10.0.0.0/24"
  address_prefix       = "192.168.1.0/24"
}

resource "azurerm_subnet" "testag-subnet-2" {
  name                 = "testag-subnet-2"
  resource_group_name  = azurerm_resource_group.testag.name
  virtual_network_name = azurerm_virtual_network.testag.name
  address_prefix       = "192.168.2.0/24"
}

resource "azurerm_subnet" "AzureBastionSubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.testag.name
  virtual_network_name = azurerm_virtual_network.testag.name
  address_prefix       = "192.168.3.0/24"
}

resource "azurerm_network_security_group" "testag-instance" {
    name                = "testag-instance-nsg"
    location            = var.location
    resource_group_name = azurerm_resource_group.testag.name

    security_rule {
        name                       = "HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "SSH"
        priority                   = 102
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}
