{
  config,
  lib,
  mkSystemModule,
  ...
}:
let
  cfg = config.soul.settings.time;
in
mkSystemModule {
  shared.options.soul.settings.time = {
    timeZone = lib.mkOption {
      default = "Europe/Brussels";
      description = "The time zone to use on the system.";
      example = "America/New_York";
      type = lib.types.str;
    };
  };

  nixos.options.soul.settings.time = {
    automatic = lib.mkOption {
      default = false;
      description = "Whether to determine the time zone from the current location.";
      example = true;
      type = lib.types.bool;
    };
  };

  darwin.config.time = {
    timeZone = cfg.timeZone;
  };

  nixos.config = {
    time.timeZone = if cfg.automatic then null else cfg.timeZone;
    services.automatic-timezoned.enable = cfg.automatic;
  };
}
