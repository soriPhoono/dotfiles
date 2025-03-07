{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.programs.one-password;
in {
  options.desktop.programs.one-password.enable = lib.mkEnableOption "Enable one-password and it's gui client";

  config = lib.mkIf cfg.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = map (user: user.name) config.core.suites.users.users;
      };
    };

    /*
    home-manager.users = lib.listToAttrs
      (user: {
        inherit (user) name;
      })
    */
  };
}
