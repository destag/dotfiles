#!/bin/bash

set -o errexit
set -o pipefail

current_path="$PWD"
dev_path="$HOME/dev"

work_setup() {
  git config user.email "przemyslaw.pietras@syncron.com"
  git config user.name "Przemyslaw Pietras"
  git config commit.gpgsign false
}

dsg_setup() {
  git config user.email "przemyslawp94@gmail.com"
  git config user.name "Przemyslaw Pietras"
}

case $1 in
  "work")
    echo "Using work config"
    work_setup
    exit
    ;;
  "dsg")
    echo "Using dsg config"
    dsg_setup
    exit
    ;;
  *)
    echo "No setup specified, using path specific setup"
    ;;
esac

case "$current_path" in
  "$dev_path/work"*)
    echo "Using [work] config"
    work_setup
    ;;
  "$dev_path/freelance"*)
    echo "Using [dsg] config"
    dsg_setup
    ;;
  "$dev_path/personal"*)
    echo "Using [dsg] config"
    dsg_setup
    ;;
  "$dev_path/other"*)
    echo "Using [dsg] config"
    dsg_setup
    ;;
  *)
    echo "Current working directory is NOT in any of the desired paths."
    exit 1
    ;;
esac
