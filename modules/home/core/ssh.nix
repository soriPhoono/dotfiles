{
  lib,
  config,
  ...
}: {
  options.core.ssh = {
    publicKey = lib.mkOption {
      type = lib.types.str;
      description = "Public SSH key to use for authentication";
    };
  };

  config = {
    home.file.".ssh/id_ed25519.pub".text = config.core.ssh.publicKey;

    sops.secrets.ssh_key.path = "${config.home.homeDirectory}/.ssh/id_ed25519";

    programs.ssh.enable = true;
  };
}
