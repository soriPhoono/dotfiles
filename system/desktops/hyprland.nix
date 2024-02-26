{ config, pkgs, ... }: {
  imports = [
    ./regreet.nix
  ];

  services = {
    greetd = {
      settings = {
        default_session = {
          # TODO: change the wayland compositor to hyprland
          command = "cage -s -- ${pkgs.regreet}/bin/regreet";
        };
      };
    };
  };

  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
}
