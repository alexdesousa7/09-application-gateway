#v0_1
resource "azurerm_resource_group" "testag" {
  name     = "applicaiton-gateway-testag"
  location = var.location
}
