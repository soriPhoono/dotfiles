{
  lib,
  config,
  ...
}: let
  cfg = config.core.editors.neovim;
in {
  options.core.editors.neovim = {
    enable = lib.mkEnableOption "Enable neovim editor";
  };

  config = {
    programs.neovim = {
      inherit (cfg) enable;
    };
  };
}
