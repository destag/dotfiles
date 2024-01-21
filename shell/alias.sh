#!/bin/bash

# system
alias _='sudo'
alias zshconf='$EDITOR $HOME/.zshrc && source $HOME/.zshrc'
alias vimconf='$EDITOR $HOME/.vimrc'
alias gitconf='$EDITOR $HOME/.gitconfig'
alias :q='exit'
alias q='exit'
alias rst='exec $SHELL -l'
alias ssh='TERM=xterm-color ssh'
alias vpn='sudo openvpn ~/.vpn/openvpn-config/SyncronVPN-other.ovpn'
alias vpn-all='sudo openvpn ~/.vpn/openvpn-config/SyncronVPNAllTraffic-other.ovpn'
alias rm!='rm -rfv'
alias cdtmp='cd `mktemp -d`'
alias cat='batcat -pp'
alias bat='batcat'
alias dotinstall="~/.dotfiles/install"
alias flatpak-update="flatpak remote-ls --updates && flatpak update"

# tools
alias a='ansible'
alias ap='ansible-playbook'
alias tf='terraform'
alias py='python'
alias py-act='source .venv/bin/activate'
alias py-dact='deactivate'
alias py-venv='python -m venv .venv && source .venv/bin/activate'
alias xc='xclip -selection clipboard'
alias vimf='vim `fzf`'
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
alias h='helm'
