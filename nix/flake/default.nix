{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args

    ./systems.nix
    ./treefmt.nix
  ];
}
