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

  soul.server = {
    domain = "luna.fish";
    acme.enable = true;
  };

  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
  };

  soul.services = {
    tangled.enable = true;
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
    config.networking.wg-quick.interfaces.wg0.listenPort
  ];

  age.secrets = {
    "wireguard/private-key".file = "${self}/nix/secrets/blackstar/wireguard/private-key.age";
  };

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets."wireguard/private-key".path;

    peers = lib.singleton {
      publicKey = "zspuVa1g73mlsVY423UDSq+vmBxdw2vq1c8wzlrBSjI=";
      allowedIPs = [ "10.0.0.2/32" ];
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts.${config.lib.domain.mkSubDomain "jellyfin"} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://10.0.0.2:8096";
        proxyWebsockets = true;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };

    virtualHosts.${config.lib.domain.mkSubDomain "komga"} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://10.0.0.2:8001";
        proxyWebsockets = true;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };

    virtualHosts.${config.lib.domain.mkSubDomain "calibre"} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://10.0.0.2:8002";
        proxyWebsockets = true;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
