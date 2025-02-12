{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.shells.nushell;
in {
  # TODO: finish this file

  options.core.shells.nushell.enable = lib.mkEnableOption "Enable nushell integration";

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      neovim.enable = false;
      nixvim.enable = false;
    };

    programs.nushell = {
      enable = true;

      shellAliases = {
        v =
          lib.mkIf (builtins.pathExists ../../../nvim/${config.home.username}) "${inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvim (import ../../../nvim/${config.home.username})}/bin/nvim";
      };
    };
  };
}
