{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop.programs.ags;
in {
  imports = [ inputs.ags.homeManagerModules.default ];

  options = {
    desktop.programs.ags.enable = lib.mkEnableOption "Enable ags wayland shell";
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;

      configDir = ../../../../ags;
    };
  };
}
