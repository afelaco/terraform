# Configure repo-level Git identity
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

echo "    ✅  Git identity set for repo:"
echo "    Name:  $(git config --get user.name)"
echo "    Email: $(git config --get user.email)"
