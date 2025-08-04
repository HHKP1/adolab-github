variable "LOCATION" {
  description = "Azure region for resources"
  type        = string
}

variable "RESOURCE_NAME_PREFIX" {
  description = "Prefix for all resource names"
  type        = string
}

variable "ENV" {
  description = "Environment name (dev, qa, uat, prod)"
  type        = string
}

variable "SQL_SERVER_ADMINISTRATOR_LOGIN" {
  description = "SQL Server administrator login"
  type        = string
}

variable "SQL_SERVER_ADMINISTRATOR_PASSWORD" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}

variable "app_version" {
  description = "Application version"
  type        = string
  default     = "1.0.0"
}

### Variables with default values
variable "sql_server_version" {
  description = "SQL Server version"
  type        = string
  default     = "12.0"
}

variable "sql_server_connection_policy" {
  description = "SQL Server connection policy"
  type        = string
  default     = "Default"
}

variable "sql_server_firewall_rules" {
  description = "SQL Server firewall rules"
  type        = map(any)
  default = {
    allow_azure_services = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

variable "collation" {
  description = "SQL Database collation"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "max_size_gb" {
  description = "SQL Database max size in GB"
  type        = number
  default     = 1
}

variable "database_sku_name" {
  description = "SQL Database SKU name"
  type        = string
  default     = "Basic"
}

variable "zone_redundant" {
  description = "Enable zone redundancy"
  type        = bool
  default     = false
}

variable "sku_name" {
  description = "App Service Plan SKU name (replaces tier/size combination)"
  type        = string
  default     = "S1"
}

variable "connection_string_name" {
  description = "Connection string name"
  type        = string
  default     = "MyDbConnection"
}
