#!/bin/bash

if [ $(pgrep -c openvpn) -gt 0 ]; then
  echo "#179299"
else
  echo "#fe640b"
fi
