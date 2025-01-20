{inputs, ...}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  core = {
    hostname = "iso";
  };

  system = {
    networking = {
      enable = true;
      networkmanager.enable = true;
      ssh.enable = true;
    };
  };
}
