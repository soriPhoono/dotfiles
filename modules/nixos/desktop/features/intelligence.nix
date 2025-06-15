{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.desktop.features.intelligence;
in {
  options.desktop.features.intelligence = with lib; {
    enable = mkEnableOption "Enable selfhosted artificial intelligence";

    acceleration = mkOption {
      type = types.enum ["none" "cuda" "rocm"];
      description = "Which acceleration profile to use, defaults to none";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alpaca
    ];

    services.ollama = {
      inherit (cfg) acceleration;

      enable = true;

      user = "ollama";
      host = "localhost";
    };
  };
}
