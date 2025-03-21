{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.programs.vscode;
in {
  options.userapps.programs.vscode.enable = lib.mkEnableOption "Enable vscode editor";

  config = lib.mkIf cfg.enable {
    stylix.targets.vscode.profileNames = [
      "default"
    ];

    programs.vscode = {
      enable = true;
    };

    core.impermanence.directories = [
      ".config/Code"
      ".vscode"
    ];
  };
}
