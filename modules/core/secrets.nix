{ inputs
, config
, ...
}: {
  imports = with inputs; [
    sops-nix.nixosModules.sops
  ];

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "soriphoono ${config.networking.hostName}";

        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  sops = {
    defaultSopsFile = ./homes/soriphoono/example.yaml;

    age = {
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];

      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      example_key = {
        
      };
    };
  };
}