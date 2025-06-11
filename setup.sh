#!/usr/bin/env bash
set -euo pipefail

# Run dependency installation if install.sh exists
if [[ -f "$(dirname "$0")/install.sh" ]]; then
  "$(dirname "$0")/install.sh"
fi

# Apply symlinks
stow -t "$HOME" -d "$HOME/dotfiles" --ignore "README.md" --ignore "setup.sh" .
