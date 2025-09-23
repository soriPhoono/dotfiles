{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.development;
in {
  imports = [
    ./vscode.nix
  ];

  options.userapps.development = {
    enable = lib.mkEnableOption "Enable development tools";
  };

  config = lib.mkIf cfg.enable {
    userapps.development.vscode.enable = true;
  };
}
