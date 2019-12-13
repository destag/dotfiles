#!/bin/bash

if ! [ "$(command -v pacman)" ]; then
    red "Cannot find pacman. Aborting..."
    return
fi

packages=(
    "zsh"
    "python"
    "python-pip"
    "python-black"
    "python-pylint"
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
    "otf-fira-code"
    "firefox-developer-edition"
    "terraform"
    "vagrant"
    "etcher"
    "ncdu"
    "virtualbox"
    "vlc"
    "aws-cli"
    "bind-tools"
    "xclip"
    "nmap"
    "mypy"
)

sudo pacman -Syu --noconfirm | info
sudo pacman -Syu --noconfirm "${packages[@]}" | info
