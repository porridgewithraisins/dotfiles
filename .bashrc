#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1="\[\e[38;5;51m\]\u\[\e[0m\] [\w]\[\e[38;5;77m\]\$(parse_git_branch)\[\e[0m\] $ "

complete -cf sudo

alias rm="rm -i"

shopt -s histappend
export HISTCONTROL=ignorespace
export HISTFILESIZE=10000
export HISTSIZE=${HISTFILESIZE}


stty werase \^H

if [[ -n $SSH_CONNECTION ]]; then
    PS1="($(cat /etc/hostname)) $PS1"
fi

alias d="dig +short @dns.toys"

alias c=code
alias l=ls
