{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop.ags;
in {
  imports = [ inputs.ags.homeManagerModules.default ];

  options = {
    desktop.ags.enable = lib.mkEnableOption "Enable ags wayland shell";
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;

      configDir = ../../../../ags;

      extraPackages = with pkgs; [ bun ];
    };

  };
}
