{ pkgs, ... }: {
  hardware.opengl = {
    enable = true;

    extraPackages = with pkgs; [

    ];

    extraPackages32 = with pkgs; [

    ];
  };
}
