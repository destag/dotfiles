#!/bin/bash

if ! [ "$(command -v pacman)" ]; then
    red "Cannot find pacman. Aborting..."
    return
fi

packages=(
    "zsh"
    "python"
    "python-pip"
    "wget"
    "tmux"
    "htop"
    "neofetch"
    "ansible"
    "code"
    "vim"
    "ranger"
    "git"
    "termite"
    "jq"
    "go"
    "docker"
    "fzf"
    "httpie"
    "nodejs"
    "system-config-printer"
)

sudo pacman -Syu --noconfirm | info
sudo pacman -Syu --noconfirm "${packages[@]}" | info
