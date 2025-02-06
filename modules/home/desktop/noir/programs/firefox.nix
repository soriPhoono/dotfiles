{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles = {
        soriphoono = {
          bookmarks = [
          ];

          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
        };
      };
    };

    desktop.noir.extraBinds = [
      "$mod, B, exec, firefox"
    ];
  };
}
