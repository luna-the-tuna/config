{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.hardware.amdgpu;
in
mkNixosModule {
  options.soul.hardware.amdgpu = {
    enable = lib.mkEnableOption "amd gpu";
  };

  config = lib.mkIf cfg.enable {
    hardware.amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };

    services.xserver.videoDrivers = [
      "amdgpu"
    ];
  };
}
