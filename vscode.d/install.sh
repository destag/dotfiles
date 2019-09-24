#!/bin/bash

if ! [ "$(command -v code)" ]; then
    red "Cannot find vscode. Aborting..."
    return
fi

VSCODE_DIR="$HOME/.config/Code - OSS/User"

code \
    --install-extension zhuangtongfa.material-theme \
    --install-extension pkief.material-icon-theme \
    --install-extension mauve.terraform \
    --install-extension ms-python.python \
    --install-extension ms-vscode.go \
    --install-extension tabnine.tabnine-vscode \
    --install-extension eamodio.gitlens \
    --install-extension ms-azuretools.vscode-docker \
    --install-extension vncz.vscode-apielements \
    --install-extension timonwong.shellcheck \
    --install-extension editorconfig.editorconfig \
    | info

if ! [ -L "$VSCODE_DIR/settings.json" ]; then
    rm "$VSCODE_DIR/settings.json"
    ln -s "$CONF_DIR/vscode.d/settings.json" "$VSCODE_DIR/settings.json"
    yellow "Created link: $VSCODE_DIR/settings.json"
else
    green "Link already exists: $VSCODE_DIR/settings.json"
fi

if ! [ -L "$VSCODE_DIR/snippets" ]; then
    rm -r "$VSCODE_DIR/snippets"
    ln -s "$CONF_DIR/vscode.d/snippets" "$VSCODE_DIR/snippets"
    yellow "Created link: $VSCODE_DIR/snippets"
else
    green "Link already exists: $VSCODE_DIR/snippets"
fi
