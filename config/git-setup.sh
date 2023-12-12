#!/bin/bash

set -o errexit
set -o pipefail

current_path="$PWD"
dev_path="$HOME/dev"

case $1 in
"work")
  echo "Using work config"
  git config user.email "przemyslaw.pietras@syncron.com"
  git config user.name "Przemyslaw Pietras"
  exit
  ;;
"dsg")
  echo "Using dsg config"
  git config user.email "przemyslawp94@gmail.com"
  git config user.name "Przemyslaw Pietras"
  exit
  ;;
*)
  echo "No setup specified, using path specific setup"
  ;;
esac

case "$current_path" in
"$dev_path/syncron"*)
  echo "Using [work] config"
  git config user.email "przemyslaw.pietras@syncron.com"
  git config user.name "Przemyslaw Pietras"
  ;;
"$dev_path/freelance"*)
  echo "Using [freelance] config"
  git config user.email "przemyslawp94@gmail.com"
  git config user.name "Przemyslaw Pietras"
  ;;
"$dev_path/personal"*)
  echo "Using [personal] config"
  git config user.email "przemyslawp94@gmail.com"
  git config user.name "Przemyslaw Pietras"
  ;;
"$dev_path/other"*)
  echo "Using [other] config"
  git config user.email "przemyslawp94@gmail.com"
  git config user.name "Przemyslaw Pietras"
  ;;
*)
  echo "Current working directory is NOT in any of the desired paths."
  exit 1
  ;;
esac
