output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "app_service_name" {
  description = "Name of the created App Service"
  value       = azurerm_app_service.app_service.name
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_app_service.app_service.default_site_hostname}"
}

output "app_service_staging_url" {
  description = "URL of the App Service staging slot"
  value       = var.ENV == "prod" ? "https://${azurerm_app_service.app_service.name}-staging.azurewebsites.net" : "N/A - Only available in PROD"
}

output "sql_server_name" {
  description = "Name of the created SQL Server"
  value       = azurerm_sql_server.sql_server.name
}

output "sql_database_name" {
  description = "Name of the created SQL Database"
  value       = azurerm_sql_database.sql_db.name
}
