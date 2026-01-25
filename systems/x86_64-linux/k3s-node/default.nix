{
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  core = {
    gitops = {
      enable = true;
      repo = "https://github.com/soriphoono/homelab.git";
      name = "k3s-node";
    };
    users = {
      soriphoono = {
        hashedPassword = "$6$x7n.SUTMtInzs2l4$Ew3Zu3Mkc4zvuH8STaVpwIv59UX9rmUV7I7bmWyTRjomM7QRn0Jt/Pl/JN./IqTrXqEe8nIYB43m1nLI2Un211";
        admin = true;
        shell = pkgs.fish;
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPcVuhOU+afO33xi1Jb0VHZXlDwXMl0smJnxzSwZpysG soriphoono@zephyrus";
      };
    };
  };

  hosting.mode = "cluster";
}
