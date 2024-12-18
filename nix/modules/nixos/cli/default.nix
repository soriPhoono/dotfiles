{
  imports = [
    ./boot.nix
    ./networking.nix

    ./hardware/bluetooth.nix
    ./hardware/graphics.nix
    ./hardware/graphics/amdgpu.nix
    ./hardware/inputs.nix
  ];
}
