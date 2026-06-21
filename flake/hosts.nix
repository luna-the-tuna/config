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
    inputs.disko.nixosModules.default
  ];

  modules.darwin = [
    inputs.agenix.darwinModules.default
  ];
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    useGlobalPkgs = true;

    hosts.blackstar = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/hosts/blackstar/configuration.nix";
    };

    hosts.crona = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/hosts/crona/configuration.nix";
    };

    hosts.tsubaki = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/hosts/tsubaki/configuration.nix";
    };

    shared = {
      modules = [ "${self}/system" ];
      specialArgs = { inherit self inputs keys; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
      specialArgs = self.lib.modules.mkHelpers class;
    };
  };
}
