{ inputs
, ...
}: {
  imports = with inputs; [
    sops-nix.homeManagerModules.sops

    ../modules/core
    ../modules/editors

    ../modules/themes/catppuccin.nix
  ];

  sops = {
    age.keyFile = "/home/soriphoono/.config/sops/age/keys.txt";

    defaultSopsFile = ./secrets.yaml;

    secrets = {
      ssh-private = {};
    };
  };
}
