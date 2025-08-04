locals {
  rg_name               = "rg-${var.RESOURCE_NAME_PREFIX}-${var.LOCATION}-${var.ENV}"
  app_service_plan_name = "plan-${var.RESOURCE_NAME_PREFIX}-${var.LOCATION}-${var.ENV}"
  app_service_name      = "app-${var.RESOURCE_NAME_PREFIX}-${var.LOCATION}-${var.ENV}"
  sql_server_name       = "sql-${var.RESOURCE_NAME_PREFIX}-${var.LOCATION}-${var.ENV}"
  sql_db_name           = "sqldb-${var.RESOURCE_NAME_PREFIX}-${var.LOCATION}-${var.ENV}"
}

### Creates resource group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.LOCATION
}

# Deploys app service plan (updated to use azurerm_service_plan)
resource "azurerm_service_plan" "app_service_plan" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = var.sku_name
}

# Deploys Azure web application with connection string to previously created SQL database
resource "azurerm_windows_web_app" "app_service" {
  name                = local.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    always_on = false
  }

  app_settings = {
    "Version"                = var.app_version
    "ASPNETCORE_ENVIRONMENT" = "Production"
  }

  connection_string {
    name  = var.connection_string_name
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${var.SQL_SERVER_ADMINISTRATOR_LOGIN};Password=${var.SQL_SERVER_ADMINISTRATOR_PASSWORD};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}

# Creates staging slot for production environment only
resource "azurerm_windows_web_app_slot" "app_service" {
  count          = var.ENV == "prod" ? 1 : 0
  name           = "staging"
  app_service_id = azurerm_windows_web_app.app_service.id

  site_config {
    always_on = false
  }

  app_settings = {
    "Version"                = var.app_version
    "ASPNETCORE_ENVIRONMENT" = "Production"
  }

  connection_string {
    name  = var.connection_string_name
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_db.name};Persist Security Info=False;User ID=${var.SQL_SERVER_ADMINISTRATOR_LOGIN};Password=${var.SQL_SERVER_ADMINISTRATOR_PASSWORD};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}

### Creates Azure SQL server (updated to use azurerm_mssql_server)
resource "azurerm_mssql_server" "sql_server" {
  name                         = local.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.sql_server_version
  administrator_login          = var.SQL_SERVER_ADMINISTRATOR_LOGIN
  administrator_login_password = var.SQL_SERVER_ADMINISTRATOR_PASSWORD
  connection_policy            = var.sql_server_connection_policy
}

### Creates Azure SQL server firewall rule (updated to use azurerm_mssql_firewall_rule)
resource "azurerm_mssql_firewall_rule" "sql_server" {
  for_each = var.sql_server_firewall_rules

  name             = each.key
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

### Creates Azure SQL database (updated to use azurerm_mssql_database)
resource "azurerm_mssql_database" "sql_db" {
  name           = local.sql_db_name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = var.collation
  max_size_gb    = var.max_size_gb
  sku_name       = var.database_sku_name
  zone_redundant = var.zone_redundant
}
