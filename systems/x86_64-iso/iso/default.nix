{inputs, ...}: {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  core.hostname = "iso";

  system = {
    networking = {
      enable = true;
      networkmanager.enable = true;
    };

    pipewire.enable = true;
    power.enable = true;
  };

  desktop.noir.enable = true;

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
