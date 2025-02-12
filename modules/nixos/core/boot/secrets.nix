{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.boot.secrets;
in {
  options.core.boot.secrets = {
    useCustomVault = lib.mkEnableOption "Enable custom vault for sops secrets import (system level secrets)";
  };

  config = let
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  in
    lib.mkIf config.core.boot.enable {
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;

        pinentryPackage = pkgs.pinentry-curses;
      };

      services = {
        openssh = {
          inherit hostKeys;

          enable = true;

          startWhenNeeded = true;

          settings = {
            UseDns = true;
            PermitRootLogin = "prohibit-password";
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };

        pcscd.enable = true;
      };

      sops = {
        defaultSopsFile = lib.mkMerge [
          (lib.mkIf cfg.useCustomVault ../../../../secrets/${config.networking.hostName})
          (lib.mkIf (!cfg.useCustomVault) ../../../../secrets/global.yaml)
        ];

        age = {
          sshKeyPaths = map (key: key.path) hostKeys;
        };

        secrets =
          lib.genAttrs
          (map (user: "${user}/age_key") config.core.users.users)
          (name: let
            username = lib.elemAt (lib.splitString "/" name) 0;
          in {
            path = "/tmp/${username}.key";

            mode = "0440";
            owner = username;
            group = "users";
          });
      };

      core.boot.impermanence.files = map (key: key.path) hostKeys;
    };
}
