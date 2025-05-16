{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.steam;
in {
  options.desktop.steam = {
    enable = lib.mkEnableOption "Enable steam integration";
    desktop.enable = lib.mkEnableOption "Enable steam desktop";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = let
      desktop_packages = with pkgs; [
        bottles
        prismlauncher
        gzdoom
      ];
    in
      with pkgs;
        [
          mangohud
        ]
        ++ (
          if cfg.enable
          then desktop_packages
          else []
        );

    programs = {
      gamemode = {
        enable = true;
        enableRenice = true;
      };

      steam = {
        enable = cfg.desktop.enable;

        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;

        protontricks.enable = true;
      };
    };
  };
}
