{ ... }: {
  imports = [
    ../modules              # Import the system module (default system configuration).
    ../modules/cli/zsh.nix  # Import the Zsh module.

    ../system               # Import the system configuration.
  ];
}
