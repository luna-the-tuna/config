{ inputs, ... }:
{
  imports = [
    inputs.easy-hosts.flakeModule
    inputs.treefmt.flakeModule

    ./args
    ./checks
    ./lib
    ./options
    ./overlays

    ./devshell.nix
    ./hosts.nix
    ./modules.nix
    ./packages.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
