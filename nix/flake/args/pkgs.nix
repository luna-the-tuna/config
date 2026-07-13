{ inputs, ... }:
let
  config = {
    allowAliases = false;
    allowUnfree = true;
  };

  overlays = [
    inputs.extersia-pkgs.overlays.default
    inputs.lix-module.overlays.default
  ];
in
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs { inherit system config overlays; };
  };
}
