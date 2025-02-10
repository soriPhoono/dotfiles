{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.development;
in {
  options.userapps.development = {
    enable = lib.mkEnableOption "Enable software development applications";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.overrideAttrs (_: {
        src = builtins.fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64";
          sha256 = "1zrr31d0warw1a7mdr5h4jwwff5adhpv655wgxhx48gb463kv8a4";
        };
      });
    };
  };
}
