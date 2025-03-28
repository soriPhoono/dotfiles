if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting

  fastfetch

  alias rm 'gio trash'
  alias v 'nvim'

  starship init fish | source
end
