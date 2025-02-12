{
  services.openssh = {
    enable = true;

    startWhenNeeded = true;

    settings = {
      UseDns = true;
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
