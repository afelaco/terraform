submodules=(
    "azure/az-login-admin.sh"
    "azure/az-create-sp.sh"
    "azure/az-login-sp.sh"
)

echo "➡️ Running Azure sub-modules..."
for submodule in "${submodules[@]}"; do
    echo "  ➡️ Running $(basename "$submodule")..."
    source "$submodule"
done

echo "✅ Azure setup complete!"