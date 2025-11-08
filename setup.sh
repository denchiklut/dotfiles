#!/usr/bin/env bash

# Suppress (MOTD) at login
echo > "$HOME/.hushlogin"

# Install brew if not installed
command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brew installation
brew install starship fzf git-graph eza bat zoxide tmux ripgrep fd neovim stow pngpaste

# Install oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh plugins
custom="$HOME/.oh-my-zsh/custom/plugins"
typeset -A plugins=(
  ["$custom/zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["$custom/zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  ["$custom/node-bin"]="https://github.com/remcohaszing/zsh-node-bin.git"
  ["$custom/zsh-bat"]="https://github.com/fdellwing/zsh-bat.git"
  ["$custom/zsh-nvm"]="https://github.com/lukechilds/zsh-nvm"
)

for plugin in "${!plugins[@]}"; do
  [ -d "$plugin/.git" ] || git clone "${plugins[$plugin]}" "$plugin"
done

# Ensure Node (LTS) is installed & active
nvm install --lts 

# Install script for Catppuccin Tmux 
dir=$HOME/.config/tmux/plugins/catppuccin/tmux
[ -d "$dir/.git" ] || git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$dir"

# Install tpm (Tmux Plugin Manager)
tpm=$HOME/.tmux/plugins/tpm
[ -d "$tpm/.git" ] || git clone https://github.com/tmux-plugins/tpm "$tpm"

# Install tmuxifier
tmx=$HOME/.tmuxifier
[ -d "$tmx/.git" ] || git clone https://github.com/jimeh/tmuxifier.git "$tmx"

# Back up existing configuration
declare -a configs=(
  "$HOME/.zshrc"
  "$HOME/.tmux.conf"
  "$HOME/.config/nvim"
  "$HOME/.config/ghostty/config"
  "$HOME/.config/starship.toml"
)

for config in "${configs[@]}"; do
  [ -e "$config" ] && mv "$config" "$config.backup"
done

# Apply simlinks 
stow -t $HOME -d "$HOME/dotfiles" --ignore "README.md" --ignore "setup.sh" .

# Install tmux plugins
$HOME/.tmux/plugins/tpm/bin/install_plugins
