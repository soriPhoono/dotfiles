#!/usr/bin/env zsh

export PATH="/snap/bin:$PATH"

autoload -U compinit; compinit

alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y"

neofetch
eval "$(starship init zsh)"
