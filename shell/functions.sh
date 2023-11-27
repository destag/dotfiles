#!/bin/bash

mc () {
  # Create a new directory and enter it
  mkdir -p "$@" && cd "$@" || return
}

kubeconf() {
  # Update kubectl config
  aws eks --region "$1" update-kubeconfig --name "$2"
}
