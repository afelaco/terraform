# Bootstrap

This document describes the steps required to bootstrap the environment for the project.

---

# GitHub

It is required to manually create a [GitHub Personal Access Token (PAT)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) with the following scopes:

- `repo`
- `workflow`
- `read:org`

The token is then stored in `config.sh` as `GITHUB_TOKEN`.

---

# Azure

Once the Service Principal is created via the bootstrap script, find its Object ID in the Azure Portal and copy its value 
as an `object_id` sensitive variable in `./variables.tf` file:

```hcl
variable "object_id" {
  description = "Object ID of the service principal"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
  sensitive   = true
}
```

---

# Docs

> [Homebrew Bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile).

> [Git](https://docs.github.com/en/get-started/git-basics/setting-your-username-in-git).
