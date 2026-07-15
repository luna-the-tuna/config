{
  config,
  keys,
  mkSystemModule,
  ...
}:
mkSystemModule {
  nixos.age.secrets = {
    "passwords/root".file = config.lib.users.getPasswordFile "root";
  };

  nixos.users.users.root = {
    hashedPasswordFile = config.age.secrets."passwords/root".path;
  };

  shared.users.users.root = {
    openssh.authorizedKeys.keys = keys.all;
  };
}
