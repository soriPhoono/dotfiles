{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.editors.neovim;
in {
  options.core.editors.neovim = {
    enable = lib.mkEnableOption "Enable neovim editor";
  };

  config = {
    home.packages = with pkgs; [
      neovim
    ];
  };
}
