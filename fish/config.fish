
# start tmux
#if status is-interactive
#and not set -q TMUX
#    exec tmux
#end

# enable vim mode in terminal
function fish_user_key_bindings
  fish_vi_key_bindings
  fzf_key_bindings
end

function fish_mode_prompt
   # NOOP - Disable vim mode indicator
end

# remove fish greeter
set fish_greeting

# aliases

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias clr='clear'
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias vi3="vim ~/.config/i3/config"
alias r="ranger"
alias n="nnn"
alias svim="sudo vim"
alias e="exit"
alias lynx="lynx -vikeys"
alias c="cat"
alias v="vim"
alias lk="lsblk"
alias vix="vim ~/.xmonad/xmonad.hs"
alias vixb="vim ~/.config/xmobar/xmobarrc0"
