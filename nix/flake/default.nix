{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./systems.nix
    ./treefmt.nix
  ];
}
