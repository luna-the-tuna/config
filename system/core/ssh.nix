{ mkSystemModule, ... }:
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh.settings = {
    PasswordAuthentication = true;
  };
}
