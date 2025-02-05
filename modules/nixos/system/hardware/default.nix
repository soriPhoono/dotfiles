{
  imports = [
    ./intelgpu.nix
    ./amdgpu.nix
    ./nvidia.nix

    ./bluetooth.nix
  ];

  services.fstrim.enable = true;
}
