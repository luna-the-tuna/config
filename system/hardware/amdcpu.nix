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
    enable = lib.mkEnableOption "amdcpu";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "kvm-amd" ];
    hardware.cpu.amd.updateMicrocode = true;
  };
}
