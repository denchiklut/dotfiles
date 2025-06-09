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

export FZF_DEFAULT_OPTS='--preview "bat --color=always --line-range :500 {}"'

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"                           "$@" ;;
    ssh)          fzf --preview 'dig {}'                                     "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}'                   "$@" ;;
  esac
}

alias wstorm='open -na "WebStorm.app" --args'
alias vim="nvim"

export plugins=(git eza fzf zsh-nvm dotenv node-bin npm zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.rd/bin:$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"
alias t="tmux"
alias tmx="tmuxifier"
alias tmw="tmuxifier s work"
alias tmc="tmuxifier s config"

eval "$(zoxide init --cmd cd zsh)"
