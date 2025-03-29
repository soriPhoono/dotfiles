if status is-interactive
  # Disable welcome hint
  set -U fish_greeting

  # Prompt line
  starship init fish | source

  # Splash screen
  fastfetch

  # Sane defaults
  alias ls 'eza --git --icons --group-directories-first'
  alias la 'ls -a'
  alias ll 'ls -l'
  alias lt 'ls --tree'
  alias lta 'ls -a --tree'
  alias llt 'ls -l --tree'
  alias lla 'ls -la'

  alias rm 'gio trash'

  # Tool shortcuts
  alias v 'nvim'
end
