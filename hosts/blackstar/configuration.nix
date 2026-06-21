{ inputs, config, ... }:
{
  imports = [
    inputs.tangled.nixosModules.knot

    ./disk-configuration.nix
    ./hardware-configuration.nix
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  soul.boot = {
    loader = "grub";
  };

  soul.hardware = {
    amdcpu.enable = true;
  };

  soul.users.luna = {
    primary = true;
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.lib.soul.users.primary.email;
  };

  services.tangled.knot = {
    enable = true;
    stateDir = "/var/lib/tangled/knot";

    repo = {
      scanPath = "${config.services.tangled.knot.stateDir}/repos";
    };

    server = {
      owner = "did:plc:5odpemgsnxty3zbaahu77rhv";
      hostname = "knot.luna.fish";
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts.${config.services.tangled.knot.server.hostname} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://${config.services.tangled.knot.server.listenAddr}";
        proxyWebsockets = true;
      };
    };
  };
}
