{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    {
      wsl = {
        enable = true;
        defaultUser = config.core.admin.name;
      };
    }
  ];

  core = {
    hostname = "wsl";
    secrets.defaultSopsFile = ../../../secrets/wsl/system.yaml;
  };

  system.themes = {
    enable = true;
    catppuccin.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };
}
