{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.programs.wireshark;
in
  with lib; {
    options.desktop.programs.wireshark = {
      enable = mkEnableOption "Wireshark network protocol analyzer";
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [ pkgs.wireshark ];

      programs.wireshark = {
        enable = true;

        dumpcap.enable = true;
        usbmon.enable = true;
      };

      users.extraUsers =
        builtins.mapAttrs (name: user: {
          extraGroups = [
            "wireshark"
          ];
        })
        (filterAttrs
          (name: content: content.admin)
          config.core.users);
    };
  }
