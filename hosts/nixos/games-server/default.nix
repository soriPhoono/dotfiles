{ inputs, ... }: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  
}
