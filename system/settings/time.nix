{
  config,
  lib,
  mkSystemModule,
  ...
}:
let
  cfg = config.soul.time;
in
mkSystemModule {
  nixos.options.soul.time = {
    automatic = lib.mkEnableOption "automatic timezones";
  };

  nixos.config = {
    services.automatic-timezoned.enable = cfg.automatic;
  };

  shared.config = {
    time.timeZone = lib.mkDefault "Europe/Brussels";
  };
}
