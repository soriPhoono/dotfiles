{
  inputs,
  lib,
  nixosConfigurations,
  ...
}: {
  nodes = {
    zephyrus = {
      hostname = "zephyrus";

      sshUser = "soriphoono";
      remoteBuild = false;

      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.zephyrus;
      };
    };
  };
}
