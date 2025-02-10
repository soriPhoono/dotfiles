{config, ...}: {
  imports = [
    ./intelgpu.nix
    ./amdgpu.nix
    ./nvidia.nix
  ];

  facter.reportPath = ../../../../facter/${config.networking.hostName}.json;

  services.fstrim.enable = true;
}
