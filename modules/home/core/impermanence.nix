{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.impermanence;
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  options.core.impermanence = {
    enable = lib.mkEnableOption "Enable impermanence on hardware based systems";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/nix/home/${config.home.username}" = {
      allowOther = true;

      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".gnupg"
        ".ssh"
        ".local/share/keyrings"
        ".local/share/direnv"
      ];
    };
  };
}
