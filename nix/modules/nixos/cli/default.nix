{
  imports = [
    ./boot.nix
    ./networking.nix

    ./hardware/bluetooth.nix
    ./hardware/graphics.nix
    ./hardware/amdgpu.nix
    ./hardware/inputs.nix
  ];
}
