{
  inputs,
  mkSystemModule,
  self,
  ...
}:
mkSystemModule {
  nixos.imports = [
    inputs.home-manager.nixosModules.default
  ];

  darwin.imports = [
    inputs.home-manager.darwinModules.default
  ];

  shared.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    extraSpecialArgs = { inherit self inputs; };
    sharedModules = [ "${self}/home" ];
  };
}
