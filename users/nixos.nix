{ pkgs, vars, ... }: {
  imports = [
    ../modules/home-manager/core/xdg-user-dirs.nix

    ../modules/home-manager/programs/bat.nix
    ../modules/home-manager/programs/eza.nix
    ../modules/home-manager/programs/fastfetch.nix
    ../modules/home-manager/programs/fish.nix
    ../modules/home-manager/programs/git.nix
    ../modules/home-manager/programs/nvim.nix
    ../modules/home-manager/programs/starship.nix
  ];

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt

    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
  ];

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}