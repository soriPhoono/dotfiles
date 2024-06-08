{ pkgs, vars, ... }: {
  imports = [
    ./modules/core/xdg-user-dirs.nix

    ./modules/programs
  ];

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}