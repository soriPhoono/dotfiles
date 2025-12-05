{pkgs, config, ...}: {
  imports = [
    ./boot.nix
    ./nixconf.nix
    ./secrets.nix
    ./users.nix
  ];

  console = {
    keyMap = "us";
    packages = with pkgs; [
      terminus_font
    ];
    font = lib.mkDefault "Lat2-Terminus16";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleKeyMap = "us";
    consoleFont = "Lat2-Terminus16";
  };

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

  system.stateVersion = config.system.nixos.release;
}
