{ vars, ... }: {
  services.openssh = {
    enable = true;

    hostKeys = [
      {
        comment = "${vars.defaultUser} zephyrus g14";

        path = "/etc/shh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
