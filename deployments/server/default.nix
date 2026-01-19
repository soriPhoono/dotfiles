{
  inputs,
  lib,
  nixosConfigurations,
  ...
}: {
  nodes = {
    portainer-server = {
      hostname = "portainer-server";

      sshUser = "soriphoono";

      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.portainer-server;
      };
    };
  };
}
