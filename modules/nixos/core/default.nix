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

  time.timeZone = "America/Chicago";

  system.stateVersion = "25.05";
}
