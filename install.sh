#!/bin/bash

# Brew installation
brew install starship fzf eza bat zoxide tmux neovim

# Install oh-my-zsh
[[ -d "~/.oh-my-zsh" ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh plugins
PLUGINS="$HOME/.oh-my-zsh/custom/plugins"
typeset -A plugins=(
  "https://github.com/zsh-users/zsh-autosuggestions.git" "$PLUGINS/zsh-autosuggestions"
  "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$PLUGINS/zsh-syntax-highlighting"
  "https://github.com/remcohaszing/zsh-node-bin.git" "$PLUGINS/node-bin"
  "https://github.com/fdellwing/zsh-bat.git" "$PLUGINS/zsh-bat"
  "https://github.com/lukechilds/zsh-nvm" "$PLUGINS/zsh-nvm"
)

for repo dest in ${(kv)plugins}; do
  [[ -d "$dest/.git" ]] || git clone "$repo" "$dest"
done

# Install script for Catppuccin Tmux 
dir=~/.config/tmux/plugins/catppuccin/tmux
[ -d "$dir/.git" ] || git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$dir"
