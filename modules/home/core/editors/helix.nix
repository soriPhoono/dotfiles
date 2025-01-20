{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.editors.helix;
in {
  options.core.editors.helix = {
    enable = lib.mkEnableOption "Enable helix text editor";
  };

  config = {
    home.packages = with pkgs; [
      helix
    ];
  };
}
