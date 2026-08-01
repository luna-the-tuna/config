{
  config,
  lib,
  mkNixosModule,
  self,
  ...
}:
let
  inherit (config.networking) hostName;

  cfg = config.soul.services.anki;
  server = config.services.anki-sync-server;
in
mkNixosModule {
  options.soul.services.anki = {
    enable = lib.mkEnableOption "anki";

    users = lib.mkOption {
      default = [ ];
      description = "An list of users of this service.";
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf (cfg.enable && builtins.length cfg.users != 0) {
    services.anki-sync-server = {
      enable = true;
      openFirewall = true;
      address = "127.0.0.1";

      users = map (user: {
        username = user;
        passwordFile = config.age.secrets."anki/${user}".path;
      }) cfg.users;
    };

    services.nginx.virtualHosts.${config.lib.domain.mkSubDomain "anki"} = {
      enableACME = config.security.acme.acceptTerms;
      forceSSL = config.security.acme.acceptTerms;

      locations."/" = {
        proxyPass = "http://${server.address}:${toString server.port}";
        proxyWebsockets = true;
      };
    };

    age.secrets = lib.listToAttrs (
      map (user: {
        name = "anki/${user}";
        value.file = "${self}/nix/secrets/${hostName}/anki/${user}.age";
      }) cfg.users
    );
  };
}
