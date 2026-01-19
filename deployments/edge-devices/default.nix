{
  inputs,
  lib,
  nixosConfigurations,
  ...
}: {
  nodes = {
    soriphoono-laptop = {
      hostname = "zephyrus";

      sshUser = "soriphoono";

      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.zephyrus;
      };
    };
    spookyskelly-laptop = {
      hostname = "lg-laptop";

      sshUser = "soriphoono";

      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos nixosConfigurations.lg-laptop;
      };
    };
  };
}
