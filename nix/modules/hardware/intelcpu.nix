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
    enable = lib.mkEnableOption "intel cpu";
  };

  config = lib.mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
