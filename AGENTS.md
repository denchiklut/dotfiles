# AGENTS.md — Dotfiles Repository

## Overview

Personal dotfiles repository for a macOS development environment. Contains configuration
for Neovim (NvChad), Zsh, Tmux, Ghostty terminal, Starship prompt, and related tools.
Deployed to `$HOME` via GNU Stow. The primary code is **Lua** (Neovim config) and
**Bash/Zsh** (shell scripts).

## Repository Structure

```
.config/
  ghostty/config          # Ghostty terminal emulator
  nvim/                   # Neovim configuration (NvChad v2.5 + Lazy.nvim)
    init.lua              # Entry point — bootstraps Lazy.nvim, loads plugins/options/mappings
    .stylua.toml          # StyLua formatter config
    lua/
      chadrc.lua          # NvChad theme/UI config (Catppuccin)
      mappings.lua         # All custom keybindings
      options.lua          # Vim options and autocmds
      configs/             # Per-plugin configuration modules
      plugins/init.lua     # All plugin specifications (lazy.nvim spec)
  opencode/opencode.json  # OpenCode AI tool config
  starship.toml           # Starship prompt (Catppuccin Mocha palette)
.gitconfig                # Global Git config (user, aliases, SOPS differ)
.tmux.conf                # Tmux config (Catppuccin, vim-tmux-navigator, TPM)
.tmuxifier/layouts/       # Tmuxifier session layouts
.zshrc                    # Zsh config (Oh-My-Zsh, Starship, aliases, plugins)
setup.sh                  # Bootstrap script (Homebrew, plugins, stow)
```

## Build / Setup Commands

There is no traditional build system. This is a configuration repository.

```bash
# Full bootstrap (installs Homebrew, CLI tools, Oh-My-Zsh, plugins, symlinks)
bash setup.sh

# Deploy dotfiles to $HOME via GNU Stow
stow -t $HOME -d "$HOME/dotfiles" --ignore "README.md" --ignore "setup.sh" .

# Install Homebrew packages
brew install opencode starship fzf git-graph eza bat zoxide tmux ripgrep fd neovim stow pngpaste tree-sitter-cli

# Install tmux plugins (after tmux is running)
~/.tmux/plugins/tpm/bin/install_plugins
```

## Linting and Formatting

### Lua (Neovim config)

Formatted with **StyLua**. Config at `.config/nvim/.stylua.toml`:

```bash
# Format all Lua files
stylua .config/nvim/

# Check without writing
stylua --check .config/nvim/
```

StyLua settings:
- Column width: **120**
- Indent: **2 spaces**
- Line endings: **Unix (LF)**
- Quote style: **double quotes preferred** (`AutoPreferDouble`)
- Call parentheses: **None** — use `require "module"` not `require("module")`

### JavaScript/TypeScript (in projects using this Neovim config)

- **Biome** for JS, TS, JSX, TSX, CSS
- **Prettier** for HTML, SCSS
- Format-on-save enabled (500ms timeout, LSP fallback)

### Shell scripts

- **bashls** LSP is configured for Bash files
- Use `#!/usr/bin/env bash` shebang
- Use `shellcheck` conventions (guard with `command -v`, quote variables)

## Testing

No test files exist in this repository. However, `vim-test` with `vimux` strategy
is configured for running tests in projects opened with this Neovim config:

```
:TestNearest    (<leader>u)  — Run nearest test
:TestFile       (<leader>T)  — Run current file's tests
:TestSuite      (<leader>s)  — Run full test suite
:TestLast       (<leader>l)  — Re-run last test
```

Tests execute in a tmux split pane via vimux.

## Git Conventions

### Commit message style

Use **conventional commit** prefixes with lowercase short descriptions, no body:

```
chore: updated dependencies
feat: added git config
fix: declare array for zsh
chore(general): updated dependencies
```

Prefixes used: `feat:`, `fix:`, `chore:`, `chore(scope):`.

### Branch configuration

- Default branch: **main**
- GPG signing: disabled
- `push.autoSetupRemote = true` (auto-tracks remote on first push)

## Code Style — Lua (Neovim Configuration)

### Module pattern

Every config module uses the table-export pattern:

```lua
local M = {}

M.someFunction = function()
  -- implementation
end

return M
```

Plugin specs in `plugins/init.lua` return a flat table of spec entries.

### Imports / require

Use **unparenthesized** `require` (enforced by StyLua `call_parentheses = "None"`):

```lua
-- Correct
local lazy_config = require "configs.lazy"
require "nvchad.options"

-- Wrong
local lazy_config = require("configs.lazy")
```

### Naming conventions

- **camelCase** for local variables and function names: `closeOther`, `bufnr`, `newVirtText`
- **snake_case** for Neovim API keys and plugin configuration fields
- **UPPER_CASE** not used; constants use descriptive names in module tables
- Module filenames: **lowercase**, single words or dot-separated paths

### Keybinding style

```lua
local map = vim.keymap.set
map("n", "<leader>gc", ":Neogit commit<cr>", { desc = "Commit changes" })
map("n", "<leader>tn", ":tabnext<cr>", { silent = true, desc = "Next tab" })
```

- Always provide `desc` for which-key integration
- Use `{ silent = true }` for command-mode mappings
- Alias `vim.keymap.set` as `map` and `vim.keymap.del` as `del` at module top

### Error handling

- Minimal explicit error handling; rely on Neovim's built-in error reporting
- Use guard clauses: `if not prompt or prompt == "" then return nil end`
- Use `vim.fn.confirm` for user-facing prompts before destructive actions
- Check conditions with `vim.bo[bufnr].modified`, `vim.fn.empty(vim.fn.glob(...))`

### Formatting in code

- 2-space indentation (tabs are not used)
- 120-character line width limit
- Double quotes for strings
- Trailing commas in tables
- Blank lines between logical sections
- No semicolons

## Shell Script Style (setup.sh, .zshrc)

- `#!/usr/bin/env bash` shebang for portability
- Guard installations with existence checks: `command -v brew >/dev/null || ...`
- Use `[ -d "$dir" ] || git clone ...` pattern for idempotent setup
- Quote all variable expansions: `"$HOME"`, `"$plugin"`
- Associative arrays for batch operations (plugin installs)
- Aliases defined in `.zshrc` — short, lowercase: `t`, `tf`, `tmw`, `tmc`, `gg`

## Theme

**Catppuccin Mocha** is used consistently across all tools:
- Neovim: `theme = "catppuccin"` in `chadrc.lua`
- Tmux: `@catppuccin_flavor "mocha"`
- Ghostty: `theme = catppuccin-mocha`
- Starship: Catppuccin Mocha palette

When adding new tool configurations, use the Catppuccin Mocha color scheme.

## Key Tools and Dependencies

| Tool | Purpose |
|---|---|
| GNU Stow | Symlink dotfiles to $HOME |
| Lazy.nvim | Neovim plugin manager |
| NvChad v2.5 | Neovim distribution / base config |
| Mason.nvim | Auto-installs LSP servers and formatters |
| Homebrew | macOS package manager |
| Oh-My-Zsh | Zsh framework |
| TPM | Tmux plugin manager |
| Tmuxifier | Tmux session/layout manager |
| nvm (zsh-nvm) | Node.js version manager |

## Notes for Agents

- This repo is deployed via `stow` — file paths mirror `$HOME` structure
- Do NOT create files outside the existing directory structure without reason
- Neovim plugins are managed by Lazy.nvim — add new plugins to `plugins/init.lua`
- Plugin configs go in `lua/configs/` as separate modules
- Keybindings go in `lua/mappings.lua`, not scattered across plugin configs
- The `lazy-lock.json` is auto-generated — do not edit manually
- No CI/CD exists; changes are validated by loading Neovim and running `:checkhealth`
- SOPS integration exists for encrypted files (encrypt: `<leader>ef`, decrypt: `<leader>df`)
