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

  soul.services.nginx = {
    enable = true;

    proxies = {
      calibre.target = "http://10.0.0.2:8002";
      jellyfin.target = "http://10.0.0.2:8096";
      komga.target = "http://10.0.0.2:8001";
    };
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
}
