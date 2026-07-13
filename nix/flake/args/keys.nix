{ self, ... }:
{
  _module.args.keys = import "${self}/nix/secrets/keys.nix";
}
