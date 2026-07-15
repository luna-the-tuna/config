{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  enable = config.soul.hardware.amdgpu.enable;
in
mkNixosModule {
  hardware.graphics = lib.mkIf enable {
    enable = true;
    enable32Bit = true;
  };
}
