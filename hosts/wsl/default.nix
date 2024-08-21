{ config
, inputs
, pkgs
, username
, ...
}: {
  imports = with inputs; [
    nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}
