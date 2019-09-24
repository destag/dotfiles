#!/bin/bash

export CONF_DIR="$HOME/.dotfiles"

# shellcheck disable=SC1090
source "${CONF_DIR}/utils.sh"
blue "Running bootstrap in $PWD"

for conf in "$CONF_DIR"/*.d; do
    blue "Executing configuration: $conf"

    # shellcheck disable=SC1090
    source "${conf}/install.sh"
done
