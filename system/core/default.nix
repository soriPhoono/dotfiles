{ lib, ... }: {
  imports = [
    ./boot.nix
    ./users.nix
  ];

  documentation.dev.enable = true;

  zramSwap.enable = true; # Enable zram swap.

  time.timeZone = lib.mkDefault "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8"; # Set the default locale to en_US.UTF-8.

    supportedLocales = [
      # TODO: Add your supported locales here.
    ];
  };

  console.font = lib.mkDefault "Lat2-Terminus16"; # Set the console font to Lat2-Terminus16.

  system.stateVersion = lib.mkDefault "23.11";
}
