{ config, pkgs, ... }: {
  imports = [
    ./regreet.nix
  ];

  environment.etc."greetd/hyprland.conf".text = ''
    exec-once = ${pkgs.regreet}/bin/regreet; hyprctl dispatch exit;
  '';

  services = {
    greetd = {
      settings = {
        default_session = {
          # TODO: change the wayland compositor to hyprland
          command = "${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
        };
      };
    };
  };

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
}
