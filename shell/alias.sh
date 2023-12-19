#!/bin/bash

# system
alias _='sudo'
alias zshconf='$EDITOR $HOME/.zshrc && source $HOME/.zshrc'
alias vimconf='$EDITOR $HOME/.vimrc'
alias gitconf='$EDITOR $HOME/.gitconfig'
alias :q='exit'
alias rst='exec $SHELL -l'
alias ssh='TERM=xterm-color ssh'
alias vpn='sudo openvpn ~/.vpn/openvpn-config/SyncronVPN-other.ovpn'
alias vpn-all='sudo openvpn ~/.vpn/openvpn-config/SyncronVPNAllTraffic-other.ovpn'
alias rm!='rm -rfv'
alias cdtmp='cd `mktemp -d`'

# tools
alias a='ansible'
alias ap='ansible-playbook'
alias tf='terraform'
alias py='python'
alias act='source ./venv/bin/activate'
alias dact='deactivate'
alias venv='python -m venv venv && source ./venv/bin/activate'
alias xc='xclip -selection clipboard'
alias vimf='vim `fzf`'
alias fxf='fx `fzf`'
alias j2t='jira2trello'
alias v='vagrant'
alias vup='vagrant up'

# git
alias gst='git status'
alias gt='git tree'
alias gtt='git tree -n5'
alias gtsi='git tree --simplify-by-decoration'
alias gT='git tag'
alias ga='git add'
alias gaa='git add .'
alias gup='git pull'

# kubernetes
alias k='kubectl'
