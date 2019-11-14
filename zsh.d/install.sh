#!/bin/bash

zsh -c '
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

red "Not implemented yet"
'

chsh -s /bin/zsh

if ! [ -L "$HOME/.zshrc" ]; then
    rm -r "$HOME/.zshrc"
    ln -s "$CONF_DIR/zsh.d/zshrc" "$HOME/.zshrc"
    yellow "Created link: $HOME/.zshrc"
else
    green "Link already exists: $HOME/.zshrc"
fi
