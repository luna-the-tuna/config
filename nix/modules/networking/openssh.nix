{ mkSystemModule, lib, ... }:
let
  mkKeyValue = lib.generators.mkKeyValueDefault { } " ";
  mkKeyValues = lib.generators.toKeyValue { inherit mkKeyValue; };

  settings = {
    PasswordAuthentication = true;
  };
in
mkSystemModule {
  shared.services.openssh = {
    enable = true;
  };

  nixos.services.openssh = {
    inherit settings;
  };

  darwin.services.openssh = {
    extraConfig = mkKeyValues settings;
  };
}
