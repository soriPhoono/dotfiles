#!/usr/bin/env zsh

export PATH="~/.local/bin:$PATH"
source ~/.cargo/env

autoload -U compinit; compinit

alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && cargo install-update -a"

neofetch
eval "$(starship init zsh)"
