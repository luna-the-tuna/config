{
  inputs,
  self,
  lib,
  ...
}:
let
  modules.nixos = [
    inputs.disko.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];

  modules.darwin = [
    inputs.extersia-pkgs.darwinModules.default
    inputs.home-manager.darwinModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];
in
{
  easy-hosts = {
    useGlobalPkgs = true;

    hosts.crona = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/nix/hosts/crona";
    };

    perClass = class: {
      modules = lib.getAttr class modules;
    };
  };
}
