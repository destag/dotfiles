#!/bin/bash

if ! [ "$(command -v termite)" ]; then
    red "Cannot find termite. Aborting..."
    return
fi

CONF_FILE="$HOME/.config/termite/config"

if ! [ -L "$CONF_FILE" ]; then
    rm -r "$CONF_FILE"
    ln -s "$CONF_DIR/termite.d/config" "$CONF_FILE"
    yellow "Created link: $CONF_FILE"
else
    green "Link already exists: $CONF_FILE"
fi
