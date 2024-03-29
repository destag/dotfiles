#!/bin/bash

export EDITOR="nvim"
export VISUAL="nvim"

export GOPATH="$HOME/.local/go"
export PATH="$PATH:$HOME/.local/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:/usr/lib/cargo/bin"

export PIP_REQUIRE_VIRTUALENV=1

# elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$HOME/.mix/escripts:$PATH"

# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export ASDF_GOLANG_MOD_VERSION_ENABLED=true
