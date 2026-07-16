{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.hardware.amdcpu;
in
mkNixosModule {
  options.soul.hardware.amdcpu = {
    enable = lib.mkEnableOption "amd cpu";
  };

  config = lib.mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelModules = [ "kvm-amd" ];
  };
}
