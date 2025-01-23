{
  lib,
  config,
  ...
}: let
  cfg = config.core.programs.neovim;
in {
  options.core.programs.neovim = {
    enable = lib.mkEnableOption "Enable neovim editor from the preconfigured options";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim =
      {
        enable = true;
        defaultEditor = true;
        nixpkgs.useGlobalPackages = true;
      }
      // (import ../../../nvim/${config.home.username});
  };
}
