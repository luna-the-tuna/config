{ self, inputs, ... }:
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
      specialArgs = self.lib.modules.mkHelpers class;
    };
  };
}
