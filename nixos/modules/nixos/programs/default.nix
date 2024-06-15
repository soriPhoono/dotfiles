{ vars, ... }: {
  programs = {
    gnupg.agent.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  security.pam.services.${vars.defaultUser}.gnupg.enable = true;
}
