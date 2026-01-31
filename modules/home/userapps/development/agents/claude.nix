{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.agents.claude;
in {
  options.userapps.agents.claude = {
    enable = lib.mkEnableOption "Enable Claude AI agent";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Placeholder for claude cli if available, or just common tools
      # claude-code
    ];
  };
}
