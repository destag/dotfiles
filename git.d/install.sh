#!/bin/bash

if ! [ "$(command -v git)" ]; then
    red "Cannot find git. Aborting..."
    return
fi

if grep -q 'GIT_USER' "$CONF_DIR/git.d/gitconfig"; then
    read -r -p "Git Name: " username
    sed -i "s/GIT_USER/${username}/g" "$CONF_DIR/git.d/gitconfig"
    yellow "Git name set to $username"
else
    green "Git name already set"
fi

if grep -q 'GIT_EMAIL' "$CONF_DIR/git.d/gitconfig"; then
    read -r -p "Git Email: " email
    sed -i "s/GIT_EMAIL/${email}/g" "$CONF_DIR/git.d/gitconfig"
    yellow "Git email set to $email"
else
    green "Git email already set"
fi

if ! [ -L "$HOME/.gitconfig" ]; then
    rm -r "$HOME/.gitconfig"
    ln -s "$CONF_DIR/git.d/gitconfig" "$HOME/.gitconfig"
    yellow "Created link: $HOME/.gitconfig"
else
    green "Link already exists: $HOME/.gitconfig"
fi

if ! [ -L "$HOME/.gitignore" ]; then
    rm -r "$HOME/.gitignore"
    ln -s "$CONF_DIR/git.d/gitignore" "$HOME/.gitignore"
    yellow "Created link: $HOME/.gitignore"
else
    green "Link already exists: $HOME/.gitignore"
fi
