{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  inherit (config.soul.users) admin;
  cfg = config.soul.server.acme;
in
mkNixosModule {
  options.soul.server.acme = {
    enable = lib.mkEnableOption "acme";
  };

  config.security.acme = lib.mkIf cfg.enable {
    acceptTerms = true;
    defaults.email = admin.email;
  };
}
