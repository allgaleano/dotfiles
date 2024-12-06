export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

export PATH="$HOME/.cargo/bin:$PATH"

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

export DOCKER_HOST=unix:///var/run/docker.sock

FNM_PATH="/home/galeano/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/galeano/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

alias win11-start="virsh --connect qemu:///system start win11"
alias win11-connect="xfreerdp3 /v:192.168.122.13 /u:galeano /p:galeano-arch /d:. /dynamic-resolution /size:100% -grab-keyboard > /dev/null 2>&1 & disown"
alias win11-shutdown="virsh --connect qemu:///system shutdown win11"
alias vm-list-all="virsh --connect qemu:///system list --all"
neofetch
