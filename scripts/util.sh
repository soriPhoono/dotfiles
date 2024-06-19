#!/usr/bin/env bash

function info() {
  echo "[INFO]: $1"
}

function warn() {
  echo "[WARN]: $1"
}

function error() {
  echo "[ERROR]: $1"
}

function confirm() {
  read -n 1 -rp "[INFO] $1 [y/n] "
  echo

  if [[ $REPLY != "y" ]]; then
    return 1
  fi

  return 0
}

function input() {
  read -rp "[INFO] $1: " input
  echo $input
}

function confirm_exit() {
  if confirm "Do you want to exit?"; then
    exit 0
  fi
}

trap confirm_exit SIGINT
