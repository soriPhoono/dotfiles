#!/usr/bin/env bash

function logger_init() {
  if [ -f ~/.install-log.txt ]; then
    rm ~/.install-log.txt

    info "Old log purged"
  fi
}

function logger() {
  if [ $# -eq 0 ]; then
    echo "Usage: logger \"Message\""
  fi

  message=$1

  echo "$message"
  echo "$message" >>~/.install-log.txt
}

function info() {
  if [ $# -eq 0 ]; then
    echo "Usage: logger \"Message\""
  fi

  logger "[INFO] $1"
}

function warn() {
  if [ $# -eq 0 ]; then
    echo "Usage: logger \"Message\""
  fi

  logger "[WARN] $1"
}

function err() {
  if [ $# -eq 0 ]; then
    echo "Usage: logger \"Message\""
  fi

  logger "[ERROR] $1"
}
