{
  lib,
  config,
  ...
}: let
  cfg = config.core.neovim;
in {
  options.core.neovim = {
    enable = lib.mkEnableOption "Enable neovim editor from the preconfigured options";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim =
      {
        enable = true;
        defaultEditor = true;
        nixpkgs.useGlobalPackages = true;
      }
      // (
        if (builtins.pathExists ../../nvim/${config.home.username})
        then import ../../nvim/${config.home.username}
        else {}
      );
  };
}
