{ inputs, ... }:
{
  imports = [
    inputs.easy-hosts.flakeModule
    inputs.treefmt.flakeModule

    ./args
    ./checks
    ./overlays

    ./devshell.nix
    ./hosts.nix
    ./packages.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
