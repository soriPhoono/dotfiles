{ lib, config, ... }:
let cfg = config.server.services.minecraft;
in {
  options = {
    server.services.minecraft = {
      enable = lib.mkEnableOption "Minecraft server";
    };
  };

  config = lib.mkIf cfg.enable {
    services.minecraft-server = {
      enable = true;
      declarative = true;
      openFirewall = true;

      jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";

      whitelist = {
        shadowlynch101 = "09c574f3-e8fc-4652-88ee-14cfa0b39557";
      };

      serverProperties = {
        server-port = 43000;
        difficulty = 2;
        gamemode = "adventure";
        max-players = 5;
        motd = "NixOS Minecraft server!";
        white-list = false;
        enable-rcon = false;
      };

      eula = true;
    };
  };
}
