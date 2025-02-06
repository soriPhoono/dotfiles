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

      profiles.default = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        settings = {
          extensions.autoDisableScopes = 0;
        };
      };
    };

    desktop.noir.extraBinds = [
      "$mod, B, exec, firefox"
    ];
  };
}
