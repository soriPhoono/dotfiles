{ config
, lib
, ...
}:
let cfg = config.desktop.windowManager;
in {
  options = {
    desktop.windowManager.enable = lib.mkEnableOption "Enable supporting applications for window managers";
  };

  config = lib.mkIf cfg.enable {
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "alacritty";
    };

    services = {
      gnome.sushi.enable = true;

      gvfs.enable = true;
    };
  };
}
