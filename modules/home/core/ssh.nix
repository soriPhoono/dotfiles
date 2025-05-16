{lib, ...}: {
  options.core.ssh = {
    publicKey = lib.mkOption {
      type = lib.types.str;
      description = "Public SSH key to use for authentication";
    };
  };
}
