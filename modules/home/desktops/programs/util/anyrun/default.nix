{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktops.programs.util.anyrun;
in {
  options = {
    desktops.programs.util.anyrun.enable = lib.mkEnableOption "Enable anyrun";
  };

  config = lib.mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = [
          inputs.anyrun.packages.${pkgs.system}.applications
          inputs.anyrun.packages.${pkgs.system}.rink
          inputs.anyrun.packages.${pkgs.system}.shell
          inputs.anyrun.packages.${pkgs.system}.kidex
          inputs.anyrun.packages.${pkgs.system}.websearch
        ];
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.3; };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = false;
        showResultsImmediately = false;
        maxEntries = null;
      };
    };
  };
}
