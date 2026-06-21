{ keys, mkSystemModule, ... }:
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh.settings = {
    PasswordAuthentication = true;
  };

  nixos.programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    blackstar = {
      hostNames = [ "toodeluna.net" ];
      publicKey = keys.blackstar.root;
    };

    crona = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.root;
    };
  };
}
