##!/usr/bin/env bash
#set -euo pipefail
#
#echo "Creating Terraform backend..."
#az account set --subscription "$SUBSCRIPTION_ID"
#az group create -n "$RESOURCE_GROUP" -l "$LOCATION" >/dev/null
#
#az storage account create \
#  -n "$STORAGE_ACCOUNT" \
#  -g "$RESOURCE_GROUP" \
#  -l "$LOCATION" \
#  --sku Standard_LRS >/dev/null
#
#ACCOUNT_KEY=$(az storage account keys list -g "$RESOURCE_GROUP" -n "$STORAGE_ACCOUNT" --query "[0].value" -o tsv)
#az storage container create \
#  --name "$CONTAINER_NAME" \
#  --account-name "$STORAGE_ACCOUNT" \
#  --account-key "$ACCOUNT_KEY" >/dev/null
#
#echo "✅ Terraform backend ready."