{ vars, ... }: {
  programs.gnupg.agent.enable = true;

  security.pam.services.${vars.defaultUser}.gnupg.enable = true;
}