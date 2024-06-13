{ stateVersion, ... }: {
  imports = [
    ../modules/home-manager/core/xdg-user-dirs.nix

    ../modules/home-manager/programs/bat.nix
    ../modules/home-manager/programs/development-deps.nix
    ../modules/home-manager/programs/eza.nix
    ../modules/home-manager/programs/fastfetch.nix
    ../modules/home-manager/programs/fish.nix
    ../modules/home-manager/programs/git.nix
    ../modules/home-manager/programs/nvim.nix

    ../modules/home-manager/themes/catppuccin.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${stateVersion}";
}
