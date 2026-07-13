{ inputs, ... }:
let
  config = {
    allowAliases = false;
    allowUnfree = true;
  };
in
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs { inherit system config; };
  };
}
