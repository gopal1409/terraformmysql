resource "azurerm_mysql_server" "demo" {
  name                = "mysql-training"
  location            = azurerm_resource_group.demo.location
  resource_group_name = azurerm_resource_group.demo.name

  administrator_login          = "mysqladm"
  administrator_login_password = "Admin@123456"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}
resource "azurerm_mysql_database" "training" {
  name                = "demodb"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_server.demo.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "demo-database-subnet-vnet-rule" {
  name                = "mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_server.demo.name
  subnet_id           = azurerm_subnet.demo-database-1.id
}
resource "azurerm_mysql_virtual_network_rule" "demo-subnet-vnet-rule" {
  name                = "mysql-demo-subnetvnet-rule"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  subnet_id           = azurerm_subnet.internal-1.id
}
resource "azurerm_mysql_virtual_network_rule" "demo-allow-demo-instance" {
  name                = "mysql-demo-instance"
  resource_group_name = azurerm_resource_group.demo.name
  server_name         = azurerm_mysql_server.demo.name
  start_ip_address           = azurerm_
}