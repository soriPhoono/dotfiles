#!/usr/bin/env zsh

# Path to your oh-my-zsh installation.
export ZSH="/usr/share/oh-my-zsh"
export SHELL=zsh

# Start starship
eval "$(starship init zsh)"

# oh-my-zsh plugins
plugins=(git history-substring-search)

source $ZSH/oh-my-zsh.sh

alias du="dua i"
alias df="duf"
alias ls="exa -alT --color=auto --icons -L 2 --group-directories-first --git"
alias tree="tre -al 4 -c auto"
alias cat="bat --theme Catppuccin-mocha --color auto"
alias radeontop="radeontop -c -T"
alias clock="scc"
alias compare="diff --color=always "$@" | diff-so-fancy"

neofetch
