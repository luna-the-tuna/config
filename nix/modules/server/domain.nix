{ config, lib, ... }:
let
  cfg = config.soul.server.domain;
in
{
  options.soul.server.domain = lib.mkOption {
    defaultText = lib.literalExpression "\${config.networking.hostName}.local";
    description = "The domain name of the host.";
    example = "shibusen.org";
    type = lib.types.str;
  };

  config = {
    lib.domain.mkSubDomain = subdomain: "${subdomain}.${cfg}";
    soul.server.domain = lib.mkDefault "${config.networking.hostName}.local";
    networking.domain = cfg;
  };
}
