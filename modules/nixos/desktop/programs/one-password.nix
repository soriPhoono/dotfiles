{
  lib,
  pkgs,
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

    home-manager.users =
      lib.listToAttrs
      (map (user: {
          inherit (user) name;

          value = {
            programs = {
              ssh = {
                enable = true;

                extraConfig = let
                  onePassPath = "~/.1password/agent.sock";
                in ''
                  Host *
                    IdentityAgent ${onePassPath}
                '';
              };
              git = {
                enable = true;
                extraConfig = {
                  gpg.format = "ssh";
                  "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
                  commit.gpgsign = true;
                  user.signingKey = user.publicKey;
                };
              };
            };
          };
        })
        config.core.suites.users.users);
  };
}
