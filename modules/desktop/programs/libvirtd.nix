{ lib, pkgs, config, username, ... }:
let cfg = config.desktop.programs.libvirtd;
in {
  options = {
    desktop.programs.libvirtd.enable =
      lib.mkEnableOption "Enable libvirtd virtualization machines";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };

    programs.virt-manager.enable = true;

    users.users.${username}.extraGroups = [ "libvirtd" ];
  };
}
