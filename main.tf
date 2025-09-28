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
  resource_group_name      = module.rg.resource_group_name
  storage_account_location = module.rg.resource_group_location
}

# Storage Accounts
module "sa" {
  for_each = toset(var.layer)

  source                   = "./modules/storage_account"
  storage_account_name     = "${var.project_name}${each.key}sa"
  storage_account_location = module.rg.resource_group_location
  resource_group_name      = module.rg.resource_group_name
  key_vault_id             = module.kv.key_vault_id
}

# Key Vault
module "kv" {
  source              = "./modules/key_vault"
  key_vault_name      = "${var.project_name}-kv"
  key_vault_location  = module.rg.resource_group_location
  resource_group_name = module.rg.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

# PostgreSQL Flexible Server
module "postgres" {
  source                   = "./modules/postgres"
  postgres_server_name     = "${var.project_name}-psql"
  postgres_server_location = module.rg.resource_group_location
  resource_group_name      = module.rg.resource_group_name
  postgres_database_name   = "${var.project_name}_db"
  key_vault_id             = module.kv.key_vault_id
}
