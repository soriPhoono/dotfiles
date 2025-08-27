{
  imports = [
    ./boot.nix
    ./nixconf.nix
    ./secrets.nix
    ./users.nix
  ];

  programs = {
    nix-ld.enable = true;
    nh = {
      enable = true;

      clean = {
        enable = true;
        extraArgs = "--keep-since 5d";
      };
    };
  };

  system.stateVersion = "25.11";
}
