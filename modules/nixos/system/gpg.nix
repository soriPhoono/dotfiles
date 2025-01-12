{ lib, pkgs, config, ... }:
let
  this = "system.gpg";

  cfg = config."${this}";
in
{
  options."${this}" = {
    enable = lib.mkEnableOption "Enable gnupg user agent";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
  };
}
