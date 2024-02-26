{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  programs.regreet = {
    enable = true;
  };

  environment.etc."greetd/hyprland.conf".text = ''
    exec-once = regreetd; hyprctl dispatch exit;
  '';
}
