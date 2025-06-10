# Dotfiles

This repository contains configuration files for customizing my command line environment.
It includes settings for:

- Zsh and Oh-My-Zsh
- Tmux
- Neovim (NvChad configuration under `./config/nvim`)
- Ghostty terminal
- Starship prompt

An `install.sh` script is provided to install common packages and plugins.

## Usage

1. Clone the repository:
  ```sh
  git clone https://github.com/denchiklut/dotfiles.git ~/dotfiles
  ```

2. Run the setup script:
  ```sh
  zsh ~/dotfiles/setup.sh
  ```

3. Open tmux and Press `C-Space I` (capital i, as in Install) to fetch the plugin.
4. Open Neovim and run `:MasonInstallAll` to install LSPs
