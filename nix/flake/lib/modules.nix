{ self, lib, ... }:
{
  flake.lib.modules = {
    mkNixosModule = class: module: self.lib.modules.mkSystemModule class { nixos = module; };
    mkDarwinModule = class: module: self.lib.modules.mkSystemModule class { darwin = module; };

    mkHelpers = class: {
      mkSystemModule = self.lib.modules.mkSystemModule class;
      mkNixosModule = self.lib.modules.mkNixosModule class;
      mkDarwinModule = self.lib.modules.mkDarwinModule class;
    };

    mkSystemModule =
      class:
      {
        shared ? { },
        nixos ? { },
        darwin ? { },
      }:
      {
        imports = lib.flatten [
          shared
          (lib.optional (class == "nixos") nixos)
          (lib.optional (class == "darwin") darwin)
        ];
      };
  };
}
