{ mkSystemModule, ... }:
mkSystemModule {
  nixos.system = {
    disableInstallerTools = true;
  };

  nixos.system.tools = {
    nixos-rebuild.enable = true;
    nixos-version.enable = true;
  };

  darwin.system.tools = {
    darwin-option.enable = false;
  };
}
