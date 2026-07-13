{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args
    ./checks

    ./devshell.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
