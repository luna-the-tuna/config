{ self, lib, ... }:
{
  flake.lib.modules = {
    mkNixosModule = class: module: self.lib.modules.mkSystemModule class { nixos = module; };
    mkDarwinModule = class: module: self.lib.modules.mkSystemModule class { darwin = module; };

    mkSystemModule = class: modules: {
      imports = lib.flatten [
        (modules.shared or { })
        (lib.optional (class == "nixos") modules.nixos or { })
        (lib.optional (class == "darwin") modules.darwin or { })
      ];
    };

    mkHelpers = class: {
      mkDarwinModule = self.lib.modules.mkDarwinModule class;
      mkNixosModule = self.lib.modules.mkNixosModule class;
      mkSystemModule = self.lib.modules.mkSystemModule class;
    };
  };
}
