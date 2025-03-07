{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.userapps.programs.bitwarden;
in {
  options.userapps.programs.bitwarden.enable = lib.mkEnableOption "Enable Bitwarden desktop and cli clients";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bitwarden-desktop
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };
  };
}
