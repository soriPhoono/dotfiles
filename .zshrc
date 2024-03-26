#!/usr/bin/env zsh

export PATH="~/.local/bin:$PATH"

autoload -U compinit; compinit

alias update="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y && cargo install-update -a"
alias du="dua i"
alias ls="eza -al --color=auto --icons --group-directories-first --git"
alias tree="tre -al 4 -c automatic"
alias cat="bat --theme Catppuccin-mocha --color auto"

neofetch
eval "$(starship init zsh)"
