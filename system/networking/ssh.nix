{ keys, mkSystemModule, ... }:
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  shared.programs.ssh.knownHosts = {
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

    tsubaki = {
      hostNames = [ "tsubaki.local" ];
      publicKey = keys.tsubaki.root;
    };
  };

  nixos.services.openssh.settings = {
    PasswordAuthentication = true;
  };
}
