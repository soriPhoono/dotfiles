{
  lib,
  config,
  ...
}: let
  cfg = config.userapps.discord;
in {
  options.userapps.discord.enable = lib.mkEnableOption "Enable discord desktop client with mods";

  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      enable = true;
      vencord.useSystem = true;
      settings = {
        discordBranch = "stable";
        appBadge = false;
        arRPC = true;
        checkUpdates = false;
        customTitleBar = true;
        disableMinSize = true;
        minimizeToTray = true;
        tray = true;
        splashTheming = true;
        staticTitle = true;
        hardwareAcceleration = true;
      };
    };
  };
}
