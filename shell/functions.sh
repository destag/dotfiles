#!/bin/bash

mc () {
  # Create a new directory and enter it
  mkdir -p "$@" && cd "$@" || return
}
