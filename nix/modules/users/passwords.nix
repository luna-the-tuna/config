{
  config,
  mkNixosModule,
  self,
  ...
}:
let
  inherit (config.networking) hostName;
  inherit (self.lib.filesystem) getRequiredPath;

  basePath = "${self}/nix/secrets/${hostName}/passwords";
in
mkNixosModule {
  lib.users.getPasswordFile = username: getRequiredPath "${basePath}/${username}.age";
}
