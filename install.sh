#!/usr/bin/env bash
set -euo pipefail

# Install dependencies via Homebrew
packages=(
  starship
  fzf
  eza
  bat
  zoxide
  tmux
  neovim
  stow
)

if command -v brew >/dev/null 2>&1; then
  brew install "${packages[@]}"
else
  echo "Homebrew not installed. Skipping brew package installation."
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install oh-my-zsh plugins
plugins_dir="$HOME/.oh-my-zsh/custom/plugins"
declare -A plugins=(
  ["https://github.com/zsh-users/zsh-autosuggestions.git"]="$plugins_dir/zsh-autosuggestions"
  ["https://github.com/zsh-users/zsh-syntax-highlighting.git"]="$plugins_dir/zsh-syntax-highlighting"
  ["https://github.com/remcohaszing/zsh-node-bin.git"]="$plugins_dir/node-bin"
  ["https://github.com/fdellwing/zsh-bat.git"]="$plugins_dir/zsh-bat"
  ["https://github.com/lukechilds/zsh-nvm"]="$plugins_dir/zsh-nvm"
)

for repo in "${!plugins[@]}"; do
  dest="${plugins[$repo]}"
  if [ ! -d "$dest/.git" ]; then
    git clone "$repo" "$dest"
  fi
done

# Install Catppuccin Tmux theme
catppuccin_dir="$HOME/.config/tmux/plugins/catppuccin/tmux"
if [ ! -d "$catppuccin_dir/.git" ]; then
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$catppuccin_dir"
fi

# Install tpm (Tmux Plugin Manager)
tpm="$HOME/.tmux/plugins/tpm"
if [ ! -d "$tpm/.git" ]; then
  git clone https://github.com/tmux-plugins/tpm "$tpm"
fi
