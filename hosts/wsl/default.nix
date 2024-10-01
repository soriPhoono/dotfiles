{ inputs, username, ... }: {
  imports = with inputs; [ nixos-wsl.nixosModules.default ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
  };

  core.openssh.enable = true;
}
