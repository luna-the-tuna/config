{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  inherit (config.soul.users) admin;
  cfg = config.soul.services.tangled;
in
mkNixosModule {
  options.soul.services.tangled = {
    enable = lib.mkEnableOption "tangled";
  };

  config = lib.mkIf cfg.enable {
    services.tangled.knot = {
      enable = true;
      stateDir = "/var/lib/tangled/knot";
      repo.scanPath = "${config.services.tangled.knot.stateDir}/repos";

      server = {
        owner = admin.did;
        hostname = config.lib.domain.mkSubDomain "knot";
      };
    };

    services.nginx = {
      enable = true;

      virtualHosts.${config.services.tangled.knot.server.hostname} = {
        enableACME = config.security.acme.acceptTerms;
        forceSSL = config.security.acme.acceptTerms;

        locations."/" = {
          proxyPass = "http://${config.services.tangled.knot.server.listenAddr}";
          proxyWebsockets = true;
        };
      };
    };
  };
}
