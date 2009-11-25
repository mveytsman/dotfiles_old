
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

