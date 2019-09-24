#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

logger() {
    echo -e "${PURPLE}$(date -Is)${NC} - $1"
}

info() {
    local msg
    if [ -z "$1" ]; then
        while read -r msg; do
            logger "${msg}"
        done
    else
        logger "$1"
    fi
}

blue() {
    local msg
    if [ -z "$1" ]; then
        while read -r msg; do
            logger "${BLUE}${msg}${NC}"
        done
    else
        logger "${BLUE}$1${NC}"
    fi
}


green() {
    local msg
    if [ -z "$1" ]; then
        while read -r msg; do
            logger "${GREEN}${msg}${NC}"
        done
    else
        logger "${GREEN}$1${NC}"
    fi
}

red() {
    local msg
    if [ -z "$1" ]; then
        while read -r msg; do
            logger "${RED}${msg}${NC}"
        done
    else
        logger "${RED}$1${NC}"
    fi
}

yellow() {
    local msg
    if [ -z "$1" ]; then
        while read -r msg; do
            logger "${YELLOW}${msg}${NC}"
        done
    else
        logger "${YELLOW}$1${NC}"
    fi
}

export blue
export green
export red
export yellow
