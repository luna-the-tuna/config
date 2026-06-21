{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.hardware.intelcpu;
in
mkNixosModule {
  options.soul.hardware.intelcpu = {
    enable = lib.mkEnableOption "intelcpu";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "kvm-intel" ];
    hardware.cpu.intel.updateMicrocode = true;
  };
}
