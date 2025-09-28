# Get current client details
data "azurerm_client_config" "current" {}

# Terraform Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "homeauto-rg"
    storage_account_name = "homeautotf"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Resource Group
module "rg" {
  source                  = "./modules/resource_group"
  resource_group_name     = "${var.project_name}-rg"
  resource_group_location = var.location
}

# Terraform Backend Infrastructure
module "tf_backend" {
  source                   = "./modules/terraform_backend"
  storage_account_name     = "${var.project_name}tf"
  resource_group_name      = module.rg.name
  storage_account_location = module.rg.location
}

# Storage Accounts
module "sa" {
  for_each = toset(var.layer)

  source                   = "./modules/storage_account"
  storage_account_name     = "${var.project_name}${each.key}sa"
  resource_group_name      = module.rg.name
  storage_account_location = module.rg.location
}

# Key Vault
module "kv" {
  source              = "./modules/key_vault"
  key_vault_name      = "${var.project_name}-kv"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = module.rg.name
  key_vault_location  = module.rg.location
}

# PostgreSQL Flexible Server
module "postgres" {
  source                         = "./modules/postgres"
  postgres_server_name           = "${var.project_name}-psql"
  resource_group_name            = module.rg.name
  postgres_server_location       = module.rg.location
  postgres_server_admin_username = var.postgres_admin_username
  postgres_server_admin_password = var.postgres_admin_password
  postgres_database_name         = "${var.project_name}_db"
}