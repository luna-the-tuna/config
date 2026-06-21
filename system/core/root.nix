{
  config,
  keys,
  mkNixosModule,
  self,
  ...
}:
mkNixosModule {
  users.users.root = {
    hashedPasswordFile = config.age.secrets."users/root".path;
    openssh.authorizedKeys.keys = keys.all;
  };

  age.secrets = {
    "users/root".file = "${self}/secrets/${config.networking.hostName}/users/root.age";
  };
}
