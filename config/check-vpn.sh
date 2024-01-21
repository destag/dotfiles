#!/bin/bash

if [ $(pgrep -c openvpn) -gt 0 ]; then
  echo "#94e2d5"
else
  echo "#fab387"
fi
