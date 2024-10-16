{ inputs, lib, pkgs, config, ... }:
let cfg = config.desktop.programs.ags;
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options = {
    desktop.programs.ags.enable = lib.mkEnableOption "Enable ags based shell";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        sass
        esbuild

        networkmanagerapplet
      ];
    };

    programs.ags = {
      enable = true;

      configDir = ../../../../ags;
    };
  };
}
