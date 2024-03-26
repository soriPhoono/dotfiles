#!/usr/bin/env zsh

export PATH="~/.local/bin:$PATH"
source ~/.cargo/env

autoload -U compinit; compinit

alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y"

neofetch
eval "$(starship init zsh)"
