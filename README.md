# Dotfiles
<img width="1483" alt="Screenshot 2025-06-12 at 1 57 31 PM" src="https://github.com/user-attachments/assets/d848419f-9587-4760-94c5-6d2a84d5ab70" />

This repository contains configuration files for customizing my command line environment.
It includes settings for:

- Zsh and Oh-My-Zsh
- Tmux
- Neovim (NvChad configuration under `./config/nvim`)
- Starship prompt

A `setup.sh` script is provided to install common packages and plugins.

## Usage

1. Clone the repository:
   ```sh
   git clone https://github.com/denchiklut/dotfiles.git ~/dotfiles
   ```

2. Run the setup script:
   ```sh
   zsh ~/dotfiles/setup.sh
   ```

3. Optionally if u wan to use AI assistent u need to provide your API keys:
   - [Anthropic](https://www.anthropic.com/)
   - [OpenAI](https://platform.openai.com/)

   You can set them up using the following commands:
   ```sh
   security add-generic-password -a $USER -s CLAUDE_API_KEY -w YOUR_API_KEY
   security add-generic-password -a $USER -s OPENAI_API_KEY -w YOUR_API_KEY
   security add-generic-password -a $USER -s CONTEXT7_API_KEY -w YOUR_API_KEY

   ```
