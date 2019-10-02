#!/bin/bash

if ! [ "$(command -v termite)" ]; then
    red "Cannot find termite. Aborting..."
    return
fi

TERMITE_DIR="$HOME/.config/termite"

mkdir -p "$TERMITE_DIR"

if ! [ -L "$TERMITE_DIR/config" ]; then
    rm -r "$TERMITE_DIR/config"
    ln -s "$CONF_DIR/termite.d/config" "$TERMITE_DIR/config"
    yellow "Created link: $TERMITE_DIR/config"
else
    green "Link already exists: $TERMITE_DIR/config"
fi
