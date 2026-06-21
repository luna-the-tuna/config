{
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
  ];

  soul.hardware = {
    intelcpu.enable = true;
  };

  soul.users.luna = {
    primary = true;
    firstName = "Luna";
    lastName = "Heyman";
    email = "luna@toodeluna.net";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    enable = true;

    virtualHosts."jellyfin.tsubaki.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };
}
