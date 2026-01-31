{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.agents.gemini;
in {
  options.userapps.agents.gemini = {
    enable = lib.mkEnableOption "Enable Gemini AI agent";
    overrideEditor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Override the default editor (VSCode) with Antigravity.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gemini-cli
    ];
  };
}
