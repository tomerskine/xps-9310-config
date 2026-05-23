# xps-9310-config

Dotfiles managed with [chezmoi](https://chezmoi.io), using 1Password for secrets and age for encryption.

## New machine setup

### Prerequisites

```bash
sudo pacman -S chezmoi age
# 1Password CLI (op) must also be installed and the desktop app running
```

### Bootstrap

1. Retrieve the age private key from 1Password and write it to disk:

   ```bash
   mkdir -p ~/.age
   op item get "chezmoi age key" --fields private_key --reveal > ~/.age/key.txt
   chmod 600 ~/.age/key.txt
   ```

2. Initialize and apply:

   ```bash
   chezmoi init --apply https://github.com/tomerskine/xps-9310-config
   ```

   This clones the repo, generates `~/.config/chezmoi/chezmoi.toml` from `.chezmoi.toml.tmpl`
   (pulling the age public key from 1Password), then applies all dotfiles — decrypting any
   `encrypted_*` files with the age key.

---

## Day-to-day usage

| Task | Command |
|------|---------|
| Add a dotfile | `chezmoi add ~/.config/foo/config` |
| Add a file encrypted | `chezmoi add --encrypt ~/.config/foo/secret` |
| Add a templated file | `chezmoi add --template ~/.config/foo/config` |
| Preview changes | `chezmoi diff` |
| Apply changes | `chezmoi apply` |
| Edit a managed file | `chezmoi edit ~/.config/foo/config` |
| Commit and push | `chezmoi cd` then `git add -A && git commit && git push` |

## Secrets

- **1Password templates**: reference secrets in dotfile templates with e.g.
  `{{ (onepasswordItemFields "my item" "Private").field_name.value }}`
- **Encrypted files**: run `chezmoi add --encrypt <file>` — chezmoi encrypts with age before
  committing, decrypts on apply. The age key lives in 1Password (see above).
- **Never commit**: raw private keys, `.env` files, or any plaintext credentials.
  The `.gitignore` blocks the most common patterns, but be deliberate.
