{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

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
}
