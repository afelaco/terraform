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
  source   = "./modules/resource_group"
  name     = "${var.project_name}-rg"
  location = var.location
}

# Terraform Backend Infrastructure
module "tf" {
  source              = "./modules/terraform_backend"
  name                = "${var.project_name}tf"
  resource_group_name = module.rg.name
  location            = module.rg.name
}

# Storage Account
module "sa" {
  source              = "./modules/storage_account"
  name                = "${var.project_name}sa"
  resource_group_name = module.rg.name
  location            = module.rg.name
}

# Key Vault
module "kv" {
  source              = "./modules/key_vault"
  name                = "${var.project_name}-kv"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = module.rg.name
  location            = module.rg.location
}