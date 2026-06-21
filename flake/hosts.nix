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

    shared.specialArgs = {
      inherit self inputs;
    };
  };
}
