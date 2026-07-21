{
  config,
  lib,
  mkNixosModule,
  self,
  ...
}:
let
  cfg = config.soul.services.nginx;

  virtualHosts = lib.mapAttrs' (
    name: proxy:
    lib.nameValuePair (config.lib.domain.mkSubDomain proxy.subdomain) (mkVirtualHostForProxy proxy)
  ) cfg.proxies;

  mkVirtualHostForProxy = proxy: {
    enableACME = true;
    forceSSL = true;

    locations."/" = {
      proxyPass = proxy.target;
      proxyWebsockets = true;

      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
  };
in
mkNixosModule {
  options.soul.services.nginx = {
    enable = lib.mkEnableOption "nginx";

    proxies = lib.mkOption {
      default = { };
      description = "An attribute set of proxies to add to the nginx configuration.";
      type = lib.types.attrsOf self.lib.types.proxy;
    };
  };

  config.services.nginx = {
    inherit virtualHosts;
    inherit (cfg) enable;
  };
}
