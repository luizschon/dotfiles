# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
unsetopt beep
bindkey -e

PATH=$PATH:$HOME/.local/bin

command -v keychain > /dev/null && eval $(keychain --eval --quiet ~/.ssh/github_ed25519)

cargo_env="$HOME/.cargo/env"
[ -f "$cargo_env" ] && source "$cargo_env"

nvm_aur_path="/usr/share/nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# Configure NVM differently depending on how it was installled
if [ -f "$nvm_aur_path/init-nvm.sh" ]; then
    source "$nvm_aur_path/init-nvm.sh"
else
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" 
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion" 
fi

#########################################
# PLUGINS
autoload -Uz compinit
compinit

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#########################################
# THEME CUSTOMIZATION

# Generate LS_COLORS
eval $(dircolors -b "$ZDOTDIR/dircolors.default")
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Prompt customization
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{2} %b%f'
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

RPROMPT='${vcs_info_msg_0_}'
PROMPT='%F{red}%(?.. )%F{magenta}%n%f in %F{cyan}%1~%f > '

#########################################
# ALIASES AND KEYBINDINGS

# See https://stackoverflow.com/questions/24226685/have-zsh-return-case-insensitive-auto-complete-matches-but-prefer-exact-matches
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char

# Colored output and code syntax highlighting for less 
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R --use-color -Dd+r$Du+b'
export MANPAGER="less -R --use-color -Dd+r -Du+b"

alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias l.='ls -d .*'
alias pm-clean='pacman -Qtdq | sudo pacman -Rns -'

export GPG_TTY=$(tty)
