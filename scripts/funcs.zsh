#!/bin/bash

mkcd() {
  mkdir -p $1 && cd $1
}

difft() {
  local width=$(tput cols)
  if [[ "$width" -lt 100 ]]; then
    local mode=inline
  else
    local mode=side-by-side
  fi

  command difft --display $mode "$@"
}
