{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in
  with lib; {
    options.userapps = {
      fileManagers = lib.mkOption {
        type = with types; listOf (enum ["dolphin" "nautilus" "thunar"]);
        description = "Choose a file manager to be installed.";
        default = [];
        example = "thunar";
      };
    };

    config = {
      environment.systemPackages =
        if (builtins.any (requestedType: requestedType == "dolphin") cfg.fileManagers)
        then [pkgs.kdePackages.dolphin]
        else [];

      programs = {
        thunar = mkIf (builtins.any (requestedType: requestedType == "thunar") cfg.fileManagers) {
          enable = true;
          plugins = with pkgs; [
            thunar-vcs-plugin
            thunar-archive-plugin
            thunar-volman
            thunar-media-tags-plugin
          ];
        };
      };
    };
  }
