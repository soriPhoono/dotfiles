{ inputs, pkgs, ... }: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    {
      wsl = {
        enable = true;

        defaultUser = "soriphoono";
      };
    }
  ];

  core.enable = true;

  themes.catppuccin.enable = true;

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
