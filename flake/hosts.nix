{
  inputs,
  lib,
  self,
  ...
}:
let
  modules.nixos = [
    inputs.agenix.nixosModules.default
  ];

  modules.darwin = [
    inputs.agenix.darwinModules.default
  ];
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    useGlobalPkgs = true;

    hosts.crona = {
      arch = "x86_64";
      class = "nixos";
      path = "${self}/hosts/crona/configuration.nix";
    };

    shared = {
      modules = [ "${self}/system" ];
      specialArgs = { inherit self inputs; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
      specialArgs = self.lib.modules.mkHelpers class;
    };
  };
}
