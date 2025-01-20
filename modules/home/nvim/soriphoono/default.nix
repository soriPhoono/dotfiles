{
  lib,
  config,
  ...
}: let
  cfg = config.nvim.soriphoono;
in {
  options.nvim.soriphoono.enable = lib.mkEnableOption "Enable soriphoono's neovim customisations";

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
