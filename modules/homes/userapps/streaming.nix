{ lib, pkgs, config, ... }:
let cfg = config.userapps.streaming;
in {
  imports = [
    ./programs/obs.nix
  ];

  options = {
    userapps.streaming.enable = lib.mkEnableOption "Enable streaming userlevel applications";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      davinci-resolve
    ];

    userapps.programs.obs-studio.enable = true;
  };
}
