{ inputs, pkgs, username, ... }: {
  imports = with inputs; [ nixos-wsl.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "${username}";

    startMenuLaunchers = true;
    useWindowsDriver = true;
  };

  environment.systemPackages = with pkgs; [ wget ];

  programs.nix-ld = {
    enable = true;

    package = pkgs.nix-ld-rs;
  };
}
