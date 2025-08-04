output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_name" {
  description = "Name of the created App Service"
  value       = azurerm_windows_web_app.app_service.name
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_windows_web_app.app_service.default_hostname}"
}

output "app_service_staging_url" {
  description = "URL of the App Service staging slot"
  value       = var.ENV == "prod" ? "https://${azurerm_windows_web_app.app_service.name}-staging.azurewebsites.net" : "N/A - Only available in PROD"
}

output "sql_server_name" {
  description = "Name of the created SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "sql_database_name" {
  description = "Name of the created SQL Database"
  value       = azurerm_mssql_database.sql_db.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}
