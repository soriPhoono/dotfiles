{ inputs, pkgs, username, ... }: {
  imports = with inputs; [ nixos-wsl.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  core.openssh.enable = true;

  environment.systemPackages = with pkgs; [ wget ];

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}
