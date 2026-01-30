{self, ...}: {
  enable = true;

  workflows =
    (builtins.listToAttrs (map (name: {
      inherit name;
      value = {
        name = "Build ${name}";
        on = {
          push = {
            branches = ["main"];
          };
          pull_request = {
            branches = ["main"];
          };
        };
        jobs = {
          build-isos = {
            runsOn = "ubuntu-latest";
            steps = [
              {
                name = "Checkout code";
                uses = "actions/checkout@v6";
              }
              {
                name = "Setup Nix";
                uses = "DeterminateSystems/nix-installer-action@main";
              }
              {
                name = "Build ${name}";
                run = "nix build .#isoConfigurations.${name}";
              }
            ];
          };
        };
      };
    }) (builtins.attrNames self.isoConfigurations)))
    // (builtins.listToAttrs (
      map (name: {
        inherit name;
        value = {
          name = "Build ${name}";
          on = {
            push = {
              branches = ["main"];
            };
            pull_request = {
              branches = ["main"];
            };
          };
          jobs = {
            build-isos = {
              runsOn = "ubuntu-latest";
              steps = [
                {
                  name = "Checkout code";
                  uses = "actions/checkout@v6";
                }
                {
                  name = "Setup Nix";
                  uses = "DeterminateSystems/nix-installer-action@main";
                }
                {
                  name = "Build ${name}";
                  run = "nix build .#proxmox-lxcConfigurations.${name}";
                }
              ];
            };
          };
        };
      }) (builtins.attrNames self.proxmox-lxcConfigurations)
    ));
}
