# Check if Azure credentials exists, otherwise run the sub-modules
if [ ! -f "$AZ_SP_CREDENTIALS_FILE" ]; then
    # Declare and run Azure sub-modules
        submodules=(
        "modules/azure/az-login-admin.sh"
        "modules/azure/az-create-sp.sh"
        "modules/azure/az-login-sp.sh"
    )

    echo "    ➡️ Running Azure sub-modules..."
    for submodule in "${submodules[@]}"; do
        echo "  ➡️ Running $(basename "$submodule")..."
        source "$submodule"
    done

    echo "    ✅ Azure bootstrap complete!"
else
    echo "    ℹ️ Credentials already exist at $AZ_SP_CREDENTIALS_FILE!"
fi
