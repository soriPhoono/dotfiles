{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  services = {
    greetd = {
      settings = {
        default_session = {
          # TODO: change the wayland compositor to hyprland
          command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        };
      };
    };
  };

  environment.etc."greetd/background.jpg".source = ../../config/login_background.jpg;

  programs.regreet = {
    enable = true;

    settings = {
      background = {
        path = "/etc/greetd/background.jpg";
        fit = "contain";
      };
    };
  };
}
