{
  imports = [
    ./bash.nix
    ./boot.nix
    ./nixconf.nix
    ./secrets.nix
    ./users.nix
  ];

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep-since 5d";
    };
  };

  system.stateVersion = "25.11";
}
