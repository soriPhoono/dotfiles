{ ... }: {
  boot.tmp = {
    useTmpfs = true; # Use a tmpfs for /tmp.
    tmpfsSize = "50%"; # 50% of RAM, increase this if nix builds start to fail due to lack of space.
    cleanOnBoot = true; # Clean /tmp on boot.
  };
}
