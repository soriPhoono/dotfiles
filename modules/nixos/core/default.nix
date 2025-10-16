{config, ...}: {
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

  time.timeZone = "America/Chicago";

  system.stateVersion = config.system.nixos.release;
}
