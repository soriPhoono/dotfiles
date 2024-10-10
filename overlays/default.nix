{ inputs, ... }: [
  inputs.neovim.overlays.default
  (import ./nerdfonts.nix)
  (import ./discord.nix)
  (import ./ags.nix)
]
