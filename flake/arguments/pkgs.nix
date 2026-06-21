{ inputs, ... }:
let
  config = {
    allowAliases = false;
    allowUnfree = true;
  };

  overlays = [
    inputs.extersia-pkgs.overlays.default
    inputs.firefox-addons.overlays.default
    inputs.lix-module.overlays.default
    inputs.self.overlays.default
  ];
in
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs { inherit system config overlays; };
    };
}
