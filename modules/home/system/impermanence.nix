{
  lib,
  config,
  ...
}: let
  cfg = config.system.impermanence;
in {
  options.system.impermanence = {
    enable = lib.mkEnableOption "Enable impermanence on hardware based systems";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist/home/${config.home.username}" = {
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
