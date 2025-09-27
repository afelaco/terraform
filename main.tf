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
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "${var.project_name}-rg"
  location = var.location
}

# Terraform Backend Infrastructure
module "terraform_backend" {
  source              = "./modules/terraform_backend"
  storage_account_name                = "${var.project_name}tf"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

# Storage Account
module "storage_account" {
  for_each = toset(var.layer)

  source               = "./modules/storage_account"
  storage_account_name = "${var.project_name}${each.key}sa"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
}

# Key Vault
module "key_vault" {
  source              = "./modules/key_vault"
  name                = "${var.project_name}-kv"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}