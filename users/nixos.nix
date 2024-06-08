{ pkgs, vars, ... }: {
  imports = [
    ./modules/core/xdg-user-dirs.nix

    ./modules/programs/bat.nix
    ./modules/programs/eza.nix
    ./modules/programs/fastfetch.nix
    ./modules/programs/fish.nix
    ./modules/programs/git.nix
    ./modules/programs/nvim.nix
    ./modules/programs/starship.nix
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