{ self, ... }:
{
  _module.args.keys = import "${self}/secrets/keys.nix";
}
