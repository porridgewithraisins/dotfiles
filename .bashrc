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
export HISTFILESIZE=-1
export HISTFILE=~/.bash_eternal_history
export HISTSIZE=-1
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTIGNORE="history:ls:l:ll:pwd:exit:clear"

stty werase \^H

if test "$SSH_CONNECTION"; then
    PS1="($(cat /etc/hostname)) $PS1"
fi

if ! pgrep ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
    ssh-add
elif ! ssh-add -l > /dev/null; then
    ssh-add
fi

alias d="dig +short @dns.toys"

alias l=ls
alias ll='ls -lA'
alias e=nvim
alias cat="bat --style=plain"
alias less="less -R"
alias breakpoint='
    while read -p"Debugging(Ctrl-d to exit)> " debugging_line
    do
        eval "$debugging_line"
    done
'
alias ...=../..
alias ....=../../..
alias .....=../../../..

export HOST="$HOSTNAME"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/bin:$GOPATH/bin"

ocr() { magick - -monochrome -negate - | tesseract stdin stdout 2>/dev/null; }

hold() { local input; input="$(cat)"; "$@" <<< "$input"; }

vtxt() { getcp text/plain - ; }
vjpg() { getcp image/jpeg - ; }
vpng() { getcp image/png - ; }
ctxt() { putcp text/plain -; }
cjpg() { putcp image/jpeg -; }
cpng() { putcp image/png -; }

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export BAT_THEME="Catppuccin Macchiato"

alias icat="kitten icat"

PROMPT_COMMAND='echo -en "\033]0;Terminal: $(dirs)\a"'
PROMPT_COMMAND=("history -a" "history -c" "history -r" "$PROMPT_COMMAND")

bind Space:magic-space

set -o noclobber
shopt -s checkwinsize
PROMPT_DIRTRIM=2

shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s cdable_vars

CDPATH=".:~"
function cd() { builtin cd "$@" > /dev/null || return; } # because if you set CDPATH, cd starts printing the directory it goes to
# so as to disambiguate for people without pwd in prompt

shopt -s globstar

alias SBS=DELTA_FEATURES+=side-by-side

open() { xdg-open "$@" &> /dev/null; }

source <(fzf --bash)

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && (echo terminal; exit 0) || (echo error; exit 1))" "$([ $? = 0 ] && echo Task finished || echo Something went wrong!)" "$(history | sed -n "\$s/^\s*[0-9]\+\s*\(.*\)[;&|]\s*alert\$/\1/p")"'

function weather() {
    while true; do
        if curl -s wttr.in/IIT+Madras?0; then
            printf "\r\033[7A"
        fi
    sleep 60
done
}

latexloop() { latexmk -pdf -pvc -emulate-aux-dir -aux-directory=/tmp/latexcrap "$@"; }

alias latexmk='latexmk -pdf -emulate-aux-dir -aux-directory=/tmp/latexcrap'

thought() { echo "$@" >> ~/research/thoughts; }

save() { echo "$@" >> ~/research/reading; }

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
