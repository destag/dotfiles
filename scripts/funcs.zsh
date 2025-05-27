#!/bin/bash

mk() {
  mkdir -p $1 && cd $1
}

aws-region() {
  export AWS_DEFAULT_REGION=$(
      echo "eu-west-1\nus-east-1\nap-northeast-1\nap-south-1\nap-southeast-1" \
      | fzf --height=7
  )
  echo "${AWS_DEFAULT_REGION:-no region}"
}

lgtm() {
  gh issue comment "$(gh issue list --assignee='@me' --state='open' | cut -f1 | head -1)" --body 'lgtm'
}
