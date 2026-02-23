eval "$(starship init zsh)"

export ZSH="$HOME/.oh-my-zsh"
export NVM_COMPLETION=true
export NVM_AUTO_USE=true

export EDITOR="nvim"
export VISUAL="nvim"

export ZLE_RPROMPT_INDENT=0
export COMPLETION_WAITING_DOTS=true
export ENABLE_CORRECTION=true
export DISABLE_AUTO_TITLE=true

zstyle ':omz:update' mode auto
zstyle ':omz:plugins:eza' 'dirs-first' yes
zstyle ':omz:plugins:eza' 'icons' yes

export FZF_DEFAULT_OPTS=$'
  --preview-window=hidden
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=border:#313244,label:#cdd6f4
'

alias wstorm='open -na "WebStorm.app" --args'
alias vim="nvim"

export plugins=(git eza fzf zsh-nvm dotenv node-bin npm zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.local/bin:$HOME/Library/pnpm:$HOME/.rd/bin:$HOME/.tmuxifier/bin:$PATH"
export CONTEXT7_API_KEY="$(security find-generic-password -a "$USER" -s CONTEXT7_API_KEY -w 2>/dev/null)"

eval "$(tmuxifier init -)"

alias t="tmux"
alias tf="tmuxifier"
alias tmw="tmuxifier s work"
alias tmc="tmuxifier s config"
alias gg="git-graph --style round"

eval "$(zoxide init --cmd cd zsh)"
