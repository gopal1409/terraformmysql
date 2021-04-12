provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "demo" {
    name = "demo"
    location = var.location
    tags = {
        env = "mysql-db"
    }
}

