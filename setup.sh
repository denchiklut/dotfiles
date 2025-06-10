# Brew installation
brew install starship fzf eza bat zoxide tmux neovim stow

# Install oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install oh-my-zsh plugins
plugins="$HOME/.oh-my-zsh/custom/plugins"
typeset -A plugins=(
  "https://github.com/zsh-users/zsh-autosuggestions.git" "$plugins/zsh-autosuggestions"
  "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$plugins/zsh-syntax-highlighting"
  "https://github.com/remcohaszing/zsh-node-bin.git" "$plugins/node-bin"
  "https://github.com/fdellwing/zsh-bat.git" "$plugins/zsh-bat"
  "https://github.com/lukechilds/zsh-nvm" "$plugins/zsh-nvm"
)

for repo dest in ${(kv)plugins}; do
  [[ -d "$dest/.git" ]] || git clone "$repo" "$dest"
done

# Install script for Catppuccin Tmux 
dir=$HOME/.config/tmux/plugins/catppuccin/tmux
[ -d "$dir/.git" ] || git clone -b v2.1.3 https://github.com/catppuccin/tmux.git "$dir"


# Install tpm (Tmux Plugin Manager)
tpm=$HOME/.tmux/plugins/tpm
[ -d "$tpm/.git" ] || git clone https://github.com/tmux-plugins/tpm "$tpm"

# Apply simlinks 
stow -t $HOME -d "$HOME/dotfiles" --ignore "README.md" --ignore "setup.sh" .
