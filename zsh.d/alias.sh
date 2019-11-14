#!/bin/bash

# system
alias _='sudo'
alias zshconf='$EDITOR $HOME/.zshrc && source $HOME/.zshrc'
alias vimconf='$EDITOR $HOME/.vimrc'
alias gitconf='$EDITOR $HOME/.gitconfig'
alias i3conf='$EDITOR $HOME/.i3/config && i3 reload'
alias :q='exit'
alias rst='exec $SHELL -l'
alias ssh='TERM=xterm-color ssh'

# tools
alias a='ansible'
alias ap='ansible-playbook'
alias tf='terraform'
alias R='ranger'
alias act='source ./venv/bin/activate'
alias dact='deactivate'
alias xc='xclip -selection clipboard'

# git
alias gst='git status'
alias gt='git tree'
alias gT='git tag'
alias ga='git add'
alias gaa='git add .'
