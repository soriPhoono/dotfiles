{ stateVersion, ... }: {
  imports = [
    ../modules/home-manager/core/xdg.nix
    ../modules/home-manager/core/utility-progs.nix

    ../modules/home-manager/programs/alacritty.nix
    ../modules/home-manager/programs/bat.nix
    ../modules/home-manager/programs/development-deps.nix
    ../modules/home-manager/programs/eza.nix
    ../modules/home-manager/programs/fastfetch.nix
    ../modules/home-manager/programs/fish.nix
    ../modules/home-manager/programs/git.nix
    ../modules/home-manager/programs/nvim.nix
    ../modules/home-manager/programs/prism-launcher.nix
    ../modules/home-manager/programs/starship.nix
    ../modules/home-manager/programs/vscode.nix
    ../modules/home-manager/programs/yt-dlp.nix

    ../modules/home-manager/services/mpris-proxy.nix

    ../modules/home-manager/hyprland

    ../modules/home-manager/themes/catppuccin.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "${stateVersion}";
}
