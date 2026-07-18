{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.networking.protonvpn;
in
mkNixosModule {
  options.soul.networking.protonvpn = {
    enable = lib.mkEnableOption "proton vpn";

    address = lib.mkOption {
      description = "The proton VPN address to use.";
      example = "10.0.0.2/24";
      type = lib.types.str;
    };

    dns = lib.mkOption {
      description = "The proton VPN DNS to use.";
      example = "10.2.0.1";
      type = lib.types.str;
    };

    endpoint = lib.mkOption {
      description = "The proton VPN endpoint to use.";
      example = "79.127.160.187:51820";
      type = lib.types.str;
    };

    privateKeyFile = lib.mkOption {
      description = "The path to the age encrypted private key file.";
      example = ./path/to/secret.age;
      type = lib.types.path;
    };

    publicKey = lib.mkOption {
      description = "The public key to use.";
      example = "bb/CPM+G5wt6VrDIdisuxrUNEqfH5hPxVw/+pYAOcWw=";
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    age.secrets = {
      "protonvpn/private-key".file = cfg.privateKeyFile;
    };

    networking.wg-quick.interfaces.protonvpn = {
      address = [ cfg.address ];
      dns = [ cfg.dns ];
      privateKeyFile = config.age.secrets."protonvpn/private-key".path;

      peers = lib.singleton {
        inherit (cfg) publicKey endpoint;
        persistentKeepalive = 25;

        allowedIPs = [
          "0.0.0.0/0"
          "::/0"
        ];
      };
    };
  };
}
