{ lib, config, ... }:
let
  cfg = config.core.fish;
in
{
  options.core.fish.enable = lib.mkEnableOption "Enable the fish shell";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        g = "git";
        v = "nvim";
      };

      shellInitLast = ''
        set fish_greeting

        fastfetch
      '';
    };
  };
}
