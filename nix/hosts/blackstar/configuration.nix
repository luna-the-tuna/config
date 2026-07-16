{ config, ... }:
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

  security.acme = {
    acceptTerms = true;
    defaults.email = config.soul.users.admin.email;
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
