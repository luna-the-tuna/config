{ mkSystemModule, ... }:
mkSystemModule {
  shared.security.sudo = {
    extraConfig = "Defaults env_reset,pwfeedback";
  };

  nixos.security.sudo = {
    enable = false;
  };
}
