if status is-interactive
  # Disable welcome hint
  set -U fish_greeting

  # Prompt line
  starship init fish | source

  # Splash screen
  fastfetch

  # Sane defaults
  alias rm 'gio trash'

  # Tool shortcuts
  alias v 'nvim'
end
