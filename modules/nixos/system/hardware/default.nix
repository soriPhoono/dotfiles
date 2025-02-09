{
  imports = [
    ./intelgpu.nix
    ./amdgpu.nix
    ./nvidia.nix
  ];

  services.fstrim.enable = true;
}
