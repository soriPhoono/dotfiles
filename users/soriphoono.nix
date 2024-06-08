{ inputs, pkgs, vars, ... }: {
  imports = [
    inputs.ags.homeManagerModule.default

    ../modules/home-manager/core/xdg.nix

    ../modules/home-manager/programs
    ../modules/home-manager/services

    ../modules/home-manager/themes/catppuccin.nix
  ];

  home.packages = with pkgs; [
    # Core development packages
    gitkraken
    
    # Nix development deps
    nil
    nixpkgs-fmt

    # Rust development deps
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer
  ];

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}