{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.fish;
in {
  options.core.fish.enable = lib.mkEnableOption "Enable the fish shell";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInitLast = ''
        set fish_greeting

        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };
  };
}
