{
  config,
  inputs,
  lib,
  self,
  ...
}:
let
  homeModules = [
    config.soul.home
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.default
    inputs.extersia-pkgs.homeModules.default
    inputs.nixvim.homeModules.default
    inputs.spicetify.homeManagerModules.default
    inputs.zen-browser.homeModules.default
  ];
in
{
  options.soul.home = lib.mkOption {
    default = { };
    description = "Home manager configuration shared between all users.";
    type = lib.types.deferredModule;
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "home-manager-backup";
      sharedModules = homeModules;
      extraSpecialArgs = { inherit self inputs; };
    };

    soul.home = { config, ... }: {
      home.stateVersion = config.home.version.release;
      programs.home-manager.enable = true;
    };
  };
}
