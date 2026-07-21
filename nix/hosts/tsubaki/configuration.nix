{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  soul.hardware = {
    intelcpu.enable = true;
  };

  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
  };

  soul.networking.protonvpn = {
    enable = true;
    address = "10.2.0.2/32";
    dns = "10.2.0.1";
    endpoint = "79.127.160.187:51820";
    publicKey = "bb/CPM+G5wt6VrDIdisuxrUNEqfH5hPxVw/+pYAOcWw=";
    privateKeyFile = "${self}/nix/secrets/tsubaki/protonvpn/private-key.age";
  };

  services.komga = {
    enable = true;
    openFirewall = true;
    settings.server.port = 8001;
  };

  services.calibre-web = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/calibre-web";

    listen = {
      ip = "0.0.0.0";
      port = 8002;
    };

    options = {
      calibreLibrary = "/srv/books";
      enableBookUploading = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d ${config.services.calibre-web.options.calibreLibrary} 0750 calibre-web calibre-web -"
  ];

  systemd.services.calibre-web.preStart = ''
    library_directory="${config.services.calibre-web.options.calibreLibrary}"

    if [ ! -f "$library_directory/metadata.db" ]; then
      ${lib.getExe' pkgs.calibre "calibredb"} add --empty --with-library "$library_directory"
    fi
  '';

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "sdhci_pci"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  networking.firewall.interfaces.wg0.allowedTCPPorts = [
    8096
  ];

  age.secrets = {
    "wireguard/private-key".file = "${self}/nix/secrets/tsubaki/wireguard/private-key.age";
  };

  networking.interfaces.enp1s0.ipv4.routes = lib.singleton {
    address = "162.19.246.218";
    prefixLength = 32;
    via = "192.168.0.1";
  };

  networking.wg-quick.interfaces.wg0 = {
    address = [ "10.0.0.2/24" ];
    privateKeyFile = config.age.secrets."wireguard/private-key".path;

    peers = lib.singleton {
      publicKey = "wedhJi5fzdWcJfY5nL5ViLYP67z7reZkyIbnF1Hc1RA=";
      allowedIPs = [ "10.0.0.1/32" ];
      endpoint = "luna.fish:51820";
      persistentKeepalive = 25;
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
