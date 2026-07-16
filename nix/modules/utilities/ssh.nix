{ keys, ... }:
{
  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    blackstar = {
      hostNames = [ "luna.fish" ];
      publicKey = keys.blackstar.root;
    };

    crona = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.root;
    };
  };

  soul.home.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."Host blackstar" = {
      HostName = "luna.fish";
      User = "luna";
    };

    settings."Host crona" = {
      HostName = "crona.local";
      User = "luna";
    };
  };
}
