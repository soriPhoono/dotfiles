{ lib, pkgs, config, ... }:
let cfg = config.userapps;
in {
  imports = [
    ./development.nix
    ./streaming.nix

    ./programs/firefox.nix
    ./programs/obs.nix
    ./programs/vscode.nix
  ];

  options = { userapps.enable = lib.mkEnableOption "Enable office programs"; };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # General applications
      bleachbit

      discord
      signal-desktop

      krita

      onlyoffice-desktopeditors
      slack
    ];

    userapps.programs.firefox.enable = true;
  };
}
