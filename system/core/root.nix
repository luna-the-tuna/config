{
  config,
  mkNixosModule,
  self,
  ...
}:
mkNixosModule {
  users.users.root = {
    hashedPasswordFile = config.age.secrets."users/root".path;
  };

  age.secrets = {
    "users/root".file = "${self}/secrets/${config.networking.hostName}/users/root.age";
  };
}
