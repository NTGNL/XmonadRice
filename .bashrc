#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#   Settings

#if [[ ! $TERM =~ screen ]]; then
#        exec tmux
#fi

bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# TERMCAP Setup
# enter blinking mode - red
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
# enter double-bright mode - bold, magenta
export LESS_TERMCAP_md=$(printf '\e[01;35m')
# turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_me=$(printf '\e[0m')
# leave standout mode
export LESS_TERMCAP_se=$(printf '\e[0m')
# enter standout mode - green
export LESS_TERMCAP_so=$(printf '\e[01;32m')
# leave underline mode
export LESS_TERMCAP_ue=$(printf '\e[0m')
# enter underline mode - blue
export LESS_TERMCAP_us=$(printf '\e[04;34m')

# Add custom enviroment
PATH=$PATH:~/Scripts

# PS1 Setup
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXITCODE="$?"

    local HOSTCOLOR="5"
    local USERCOLOR="3"
    local PATHCOLOR="4"

    PS1="\e[3${PATHCOLOR}m \w ";

    if [ $EXITCODE == 0 ]; then
        PS1+="\e[32m\$ \e[0m";
    else
        PS1+="\e[31m\$ \e[0m";
    fi
}



#Binds
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias clr='clear'
alias ls='ls -hN --color=auto --group-directories-first'
alias diff="diff --color=auto"
alias vi3="vim ~/.config/i3/config"
alias r="ranger"
alias n="nnn"
alias svim="sudo vim"
alias df='df -kTh'
alias grep='grep --color=auto'
alias free='free -h'
alias myip="curl http://ipecho.net/plain; echo"
alias lynx="lynx -vikeys"
alias e="exit"

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
set -o vi





[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH="/home/aleks/.fzf/bin:/home/aleks/Programs/fzf/bin:/home/aleks/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/aleks/Scripts:/home/aleks/.vimpkg/bin"
