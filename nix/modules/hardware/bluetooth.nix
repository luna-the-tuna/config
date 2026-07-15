{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.hardware.bluetooth;
in
mkNixosModule {
  options.soul.hardware.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings.General = {
        Experimental = true;
        FastConnectable = true;
      };

      settings.Policy = {
        AutoEnable = true;
      };
    };

    services = {
      blueman.enable = true;
    };
  };
}
