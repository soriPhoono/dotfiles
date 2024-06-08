{ pkgs, vars, ... }: {
  imports = [
    
  ];

  home.packages = with pkgs; [
    nil
    nixpkgs-fmt
  ];

  programs.home-manager.enable = true;
  
  home.stateVersion = "${vars.stateVersion}";
}