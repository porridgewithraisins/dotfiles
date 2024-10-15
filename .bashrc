#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
    git branch 2>/dev/null | grep '*' | awk '{print " (" $2 ")"}'
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\e[38;5;51m\]\u\[\e[0m\] [\w]\[\e[38;5;77m\]\$(parse_git_branch)\[\e[0m\] $ "

complete -cf sudo

alias rm="rm -i"

shopt -s histappend
shopt -s cmdhist
export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTSIZE=${HISTFILESIZE}
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTIGNORE="history:ls:l:ll:pwd:exit:clear"

stty werase \^H

if test $SSH_CONNECTION; then
    PS1="($(cat /etc/hostname)) $PS1"
fi

if ! ps ax | grep ssh-agent | grep -qv grep; then
    eval $(ssh-agent -s)
    ssh-add
elif ! ssh-add -l > /dev/null; then
    ssh-add
fi

alias d="dig +short @dns.toys"

alias l=ls
alias ll='ls -lA'
alias e=nvim
alias cat="bat --style=plain"

export HOST="$HOSTNAME"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/bin:$GOPATH/bin"

function ocr() {
    magick - -monochrome -negate - | tesseract stdin stdout 2>/dev/null
}

alias vtxt='getcp text/plain'
alias vjpg='getcp image/jpeg'
alias vpng='getcp image/png'
alias ctxt='putcp text/plain -'
alias cjpg='putcp image/jpeg -'
alias cpng='putcp image/png -'

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export BAT_THEME="Catppuccin Macchiato"

function pretty_tail() {
    bat --paging=never --style=plain -l log
}

alias icat="kitten icat"

PROMPT_COMMAND=("history -a" "history -c" "history -r")

shopt -s globstar

alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'

function open() {
    xdg-open "$@" &> /dev/null
}

source <(fzf --bash)

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && (echo terminal; exit 0) || (echo error; exit 1))" "$([ $? = 0 ] && echo Task finished || echo Something went wrong!)" "$(history | sed -n "\$s/^\s*[0-9]\+\s*\(.*\)[;&|]\s*alert\$/\1/p")"'


function weather() {
    while true; do
      if curl -s wttr.in/IIT+Madras?0; then
          sleep 60
          printf "\r\033[7A"
      fi
    done
}

function latexloop() {
    latexmk -pdf -pvc -emulate-aux-dir -aux-directory=/tmp/latexcrap "$@"
}

function thought() {
    echo "$@" >> ~/research/thoughts
}

function save() {
    echo "$@" >> ~/research/reading
}

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
