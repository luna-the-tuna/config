{
  lib,
  config,
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
    services.blueman = {
      enable = true;
    };

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };

        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
}
