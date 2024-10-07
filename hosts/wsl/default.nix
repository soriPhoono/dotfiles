{ inputs, pkgs, username, ... }: {
  imports = with inputs; [ nixos-wsl.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  environment.systemPackages = with pkgs; [ nil wget ];

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}
