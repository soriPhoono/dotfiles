{ lib, config, nixosConfig, ... }:
let
  this = "core";

  cfg = config."${this}";
in
{
  imports = [
    ./fish.nix
  ];

  options."${this}" = {
    enable = lib.mkEnableOption "Enable the core home manager feature set";
  };

  config = lib.mkIf cfg.enable {
    home.stateVersion = nixosConfig.system.stateVersion;

    programs.home-manager.enable = true;
  };
}
