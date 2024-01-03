if status is-interactive
    # Commands to run in interactive sessions can go here

    # Add ~/.local/bin to the PATH
    set -gx PATH $HOME/.local/bin $PATH

    # Create function aliases
    alias du='dua i'
    alias df='duf'
    alias ls='exa -al --color=auto --icons --group-directories-first --git'
    alias tree='tre -al 4 -c automatic $argv'
    alias cat='bat --theme Catppuccin-mocha --color auto $argv'
    alias nvtop='nvtop $argv'
    alias clock='scc $argv'
    alias compare='diff --color=always $argv | diff-so-fancy'

    # Set the prompt (starship)
    source (/usr/bin/starship init fish --print-full-init | psub)
end
