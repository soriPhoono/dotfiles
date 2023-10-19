#!/usr/bin/env zsh

# Path to your oh-my-zsh installation.
export PATH=$PATH:~/.local/bin
export ZSH="/usr/share/oh-my-zsh"
export SHELL=/usr/bin/zsh

export $(dbus-launch)

# Start starship
eval "$(starship init zsh)"

# oh-my-zsh plugins
plugins=(git history-substring-search)

source $ZSH/oh-my-zsh.sh

alias update="paru && paru -c"
alias du="dua i"
alias df="duf"
alias ls="exa -al --color=auto --icons --group-directories-first --git"
alias tree="tre -al 4 -c automatic"
alias cat="bat --theme Catppuccin-mocha --color auto"
alias radeontop="radeontop -c -T"
alias clock="scc"
alias compare="diff --color=always "$@" | diff-so-fancy"

neofetch
