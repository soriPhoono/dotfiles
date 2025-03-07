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
      bitwarden-cli
      bitwarden-desktop
    ];

    home.sessionVariables = {
      SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    };

    programs.firefox.profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
    ];
  };
}
