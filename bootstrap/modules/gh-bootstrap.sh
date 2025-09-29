# Declare and run GitHub sub-modules
    submodules=(
    "modules/github/gh-login-token.sh"
    "modules/github/gh-set-secret.sh"
)

echo "    ➡️ Running GitHub sub-modules..."
for submodule in "${submodules[@]}"; do
    echo "  ➡️ Running $(basename "$submodule")..."
    source "$submodule"
done

echo "    ✅ GitHub bootstrap complete!"