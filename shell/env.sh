#!/bin/bash

export EDITOR="vim"
export VISUAL="vim"

export PATH="$PATH:$HOME/go/bin:$HOME/.local/bin:$HOME/.cargo/bin"

export PIP_REQUIRE_VIRTUALENV=1

# elixir iex
export ERL_AFLAGS="-kernel shell_history enabled"
