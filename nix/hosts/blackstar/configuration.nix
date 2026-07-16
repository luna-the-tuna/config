{
  config,
  lib,
  self,
  ...
}:
{
  soul.boot = {
    loader.program = "grub";
  };

  soul.hardware = {
    amdcpu.enable = true;
  };

  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
  };

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sd_mod"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  networking.firewall.allowedUDPPorts = [
    config.networking.wireguard.interfaces.wg0.listenPort
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = config.soul.users.admin.email;
  };

  age.secrets = {
    "wireguard/private-key".file = "${self}/nix/secrets/blackstar/wireguard/private-key.age";
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets."wireguard/private-key".path;

    peers = lib.singleton {
      publicKey = "zspuVa1g73mlsVY423UDSq+vmBxdw2vq1c8wzlrBSjI=";
      allowedIPs = [ "10.0.0.2/32" ];
    };
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
