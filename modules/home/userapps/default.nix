{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps;
in {
  imports = [
    ./firefox.nix
    ./vscode.nix
  ];

  options.userapps = {
    enable = lib.mkEnableOption "Enable core applications and default feature-set";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # core applications
      nextcloud-client
    ];

    userapps = {
      firefox.enable = true;
      vscode.enable = true;
    };
  };
}
