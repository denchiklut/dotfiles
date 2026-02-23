# Dotfiles
![Screenshot 2025-06-12 at 1 57 31 PM](https://github.com/user-attachments/assets/d848419f-9587-4760-94c5-6d2a84d5ab70)

This repository contains configuration files and bootstrap scripts for my macOS command line environment. Everything is themed with Catppuccin Mocha and deployed to `$HOME` via GNU Stow.

## Included Configurations

- Zsh + Oh-My-Zsh (aliases, Starship prompt hook, plugin bundle)
- Tmux with Catppuccin theme, TPM, and Tmuxifier layouts
- Neovim (NvChad v2.5) under `.config/nvim`
- Ghostty terminal configuration
- Starship prompt palette at `.config/starship.toml`
- Git configuration (`.gitconfig`)
- OpenCode CLI settings (`.config/opencode`)

## Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/denchiklut/dotfiles.git ~/dotfiles
   ```

2. Run the bootstrap script (installs Homebrew, CLI tools, themes, and applies Stow symlinks):
   ```sh
   zsh ~/dotfiles/setup.sh
   ```

The script will:

- Install Homebrew (if missing) and brew packages like `neovim`, `tmux`, `stow`, `fzf`, `eza`, `ripgrep`, etc.
- Install Oh-My-Zsh plus plugins (autosuggestions, syntax highlighting, zsh-nvm, and more).
- Install Node.js LTS via `nvm`.
- Install Catppuccin Tmux theme, TPM, and Tmuxifier.
- Back up any existing configs in `$HOME` and re-link everything using GNU Stow.

After it completes, launch a new terminal session so Zsh, Tmux, and Starship pick up the fresh configuration.
