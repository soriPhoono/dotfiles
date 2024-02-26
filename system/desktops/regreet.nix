{ config, pkgs, ... }: {
  imports = [
    ../services/greetd.nix
  ];

  programs.regreet = {
    enable = true;
  };

  services.greetd
    .settings.default_session
    .command = "cage -s -- regreet";
}
