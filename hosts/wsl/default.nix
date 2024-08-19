{ pkgs, username, ... }: {
  wsl = {
    enable = true;
    defaultUser = "${username}";

    startMenuLauncher = true;
  };

  time.timeZone = "America/Chicago";

  documentation = {
    enable = false;
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  programs = {
    nix-ld = {
      enable = true;

      package = pkgs.nix-ld-rs;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    fish.enable = true;
    command-not-found.enable = true;
  };

  system.stateVersion = "24.11";
}
