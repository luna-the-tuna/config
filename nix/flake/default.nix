{ inputs, ... }:
{
  imports = [
    inputs.easy-hosts.flakeModule
    inputs.treefmt.flakeModule

    ./args
    ./checks

    ./devshell.nix
    ./hosts.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
