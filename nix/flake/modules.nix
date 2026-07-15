{ self, ... }:
{
  flake = {
    nixosModules.default = "${self}/nix/modules";
    darwinModules.default = "${self}/nix/modules";
  };
}
