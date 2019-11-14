#!/bin/bash

export CONF_DIR="$HOME/.dotfiles"

TAG="${1}"

# shellcheck disable=SC1090
source "${CONF_DIR}/utils.sh"
blue "Running bootstrap in $PWD"

if [ "${TAG}" ] && ! [ -d "${CONF_DIR}/${TAG}.d" ]; then
    red "Configuration ${TAG}.d does not exist"
    exit 1
fi

if [ "$TAG" ]; then
    blue "Executing single configuration: $CONF_DIR/$TAG.d"

    # shellcheck disable=SC1090
    source "${CONF_DIR}/${TAG}.d/install.sh"
    exit
fi

for conf in "$CONF_DIR"/*.d; do
    blue "Executing configuration: $conf"

    # shellcheck disable=SC1090
    source "${conf}/install.sh"
done
