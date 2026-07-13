{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args
    ./checks

    ./systems.nix
    ./treefmt.nix
  ];
}
