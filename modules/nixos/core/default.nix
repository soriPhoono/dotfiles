{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core;
in
  with lib; {
    imports = [
      ./boot.nix
      ./nixconf.nix
      ./secrets.nix
      ./users.nix
    ];

    options.core = {
      name = mkOption {
        type = types.str;
        description = "The name of the system for the top level configuration";
      };
    };

    config = {
      hardware.enableAllFirmware = true;

      console = {
        keyMap = "us";
        packages = with pkgs; [
          terminus_font
        ];
        font = "Lat2-Terminus16";
      };

      i18n.defaultLocale = "en_US.UTF-8";

      programs = {
        nix-ld.enable = true;
        nh = {
          enable = true;
          flake = "github:soriphoono/homelab";

          clean = {
            enable = true;
            dates = "daily";
            extraArgs = "--keep-since 3d --keep 5";
          };
        };
      };

      services.comin = {
        enable = true;
        hostname = cfg.name;
        remotes = [
          {
            name = "origin";
            url = "https://github.com/soriphoono/homelab.git";
            branches.main.name = "main";
          }
        ];
      };

      system.stateVersion = config.system.nixos.release;
    };
  }
