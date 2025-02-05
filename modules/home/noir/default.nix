{
  lib,
  config,
  ...
}: let
  cfg = config.noir;
in {
  imports = [
    ./hyprland
  ];

  options.noir = {
    enable = lib.mkEnableOption "Enable hyprland desktop configuration";
  };

  config = lib.mkIf cfg.enable {
    supporting.mako.enable = true;

    programs.kitty.enable = true;

    services.gnome-keyring.enable = true;
  };
}
