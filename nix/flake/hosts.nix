{
  inputs,
  keys,
  lib,
  self,
  ...
}:
let
  modules.nixos = [
    self.nixosModules.default
    inputs.agenix.nixosModules.default
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.extersia-pkgs.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    inputs.tangled.nixosModules.knot
  ];

  modules.darwin = [
    self.darwinModules.default
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

    hosts.blackstar = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/nix/hosts/blackstar";
    };

    hosts.crona = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/nix/hosts/crona";
    };

    hosts.tsubaki = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/nix/hosts/tsubaki";
    };

    shared = {
      specialArgs = { inherit keys; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
      specialArgs = self.lib.modules.mkHelpers class;
    };
  };
}
