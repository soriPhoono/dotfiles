{lib, ...}: {
  networking.wireless.enable = lib.mkForce false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgxxFcqHVwYhY0TjbsqByOYpmWXqzlVyGzpKjqS8mO7 soriphoono@gmail.com"
  ];

  system = {
    boot = {
      enable = true;
      plymouth.enable = true;
    };

    networking.enable = true;
    bluetooth.enable = true;

    audio.enable = true;

    location.enable = true;
  };

  themes = {
    enable = true;
    catppuccin.enable = true;
  };
}
