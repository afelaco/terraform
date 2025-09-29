# Check if Azure Service Principal credentials file exists, otherwise run sub-modules to create it
if [ ! -f "$AZ_SP_CREDENTIALS_FILE" ]; then
    # Declare and run Azure sub-modules
        submodules=(
        "modules/azure/az-login-admin.sh"
        "modules/azure/az-create-sp.sh"
    )

    echo "    ➡️ Running Azure sub-modules..."
    for submodule in "${submodules[@]}"; do
        echo "  ➡️ Running $(basename "$submodule")..."
        source "$submodule"
    done

else
    echo "    ℹ️ Credentials already exist at $AZ_SP_CREDENTIALS_FILE!"
fi

# Logint to Azure using the Service Principal credentials
source "modules/azure/az-login-sp.sh"

echo "    ✅ Azure bootstrap complete!"