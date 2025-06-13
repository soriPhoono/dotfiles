{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.vscode;
in {
  options.userapps.vscode = with lib; {
    enable = mkEnableOption "Enable development software";

    extraExtensions = mkOption {
      type = with types; listOf package;
      description = "Extra extensions to include in vscode environment";
      default = [];
      example = with pkgs.vscode-extensions; [
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = false;

      profiles.${config.home.username} = {
        extensions = cfg.extraExtensions;
      };
    };
  };
}
