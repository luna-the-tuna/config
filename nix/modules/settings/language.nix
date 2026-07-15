{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.settings.language;
in
mkNixosModule {
  options.soul.settings.language = {
    default = lib.mkOption {
      default = "en_US.UTF-8";
      description = "The default locale to use on the system.";
      example = "nl_BE.UTF-8";
      type = lib.types.str;
    };

    extra = lib.mkOption {
      default = [ "nl_BE.UTF-8/UTF-8" ];
      description = "Extra locales to install on the system.";
      example = [ "nl_NL.UTF-8/UTF-8" ];
      type = lib.types.listOf lib.types.str;
    };
  };

  config.i18n = {
    defaultLocale = cfg.default;
    extraLocales = cfg.extra;
  };
}
