{
  config,
  lib,
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
  };

  soul.networking.protonvpn = {
    enable = true;
    address = "10.2.0.2/32";
    dns = "10.2.0.1";
    endpoint = "79.127.160.187:51820";
    publicKey = "bb/CPM+G5wt6VrDIdisuxrUNEqfH5hPxVw/+pYAOcWw=";
    privateKeyFile = "${self}/nix/secrets/tsubaki/protonvpn/private-key.age";
  };

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

  services.nginx = {
    enable = true;

    virtualHosts.${config.lib.domain.mkSubDomain "jellyfin"} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };
}
