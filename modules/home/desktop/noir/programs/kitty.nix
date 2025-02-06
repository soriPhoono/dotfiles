{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.noir;
in {
  options.desktop.noir = {
    enable = lib.mkEnableOption "Enable kitty terminal";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;

    desktop.noir.extraBinds = [
      "$mod, Return, exec, kitty"
    ];
  };
}
