{
  services.openssh = {
    settings = {
      UseDns = true;
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
