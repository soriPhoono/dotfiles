{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shells.fish;
in {
  options.core.shells.fish.enable = lib.mkEnableOption "Enable the fish shell";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInitLast = ''
        set fish_greeting

        export (cat ${config.sops.secrets.environment.path})

        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };
  };
}
