{lib, ...}: {
  options.core.programs.ssh = {
    publicKey = lib.mkOption {
      type = lib.types.str;
      description = "Public SSH key to use for authentication";
    };
  };

  config = {
    programs.ssh = {
      enable = true;
      compression = true;
      controlMaster = "yes";
    };

    core.impermanence.directories = [
      ".ssh"
    ];
  };
}
