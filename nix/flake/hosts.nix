{
  inputs,
  keys,
  lib,
  self,
  ...
}:
let
  modules.nixos = [
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
  ];

  modules.darwin = [
    inputs.agenix.darwinModules.default
    inputs.catppuccin.darwinModules.catppuccin
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

    shared = {
      specialArgs = { inherit keys; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
    };
  };
}
