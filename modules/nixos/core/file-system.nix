# TODO: add glib to home.packages

{ ... }: {
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };
}
