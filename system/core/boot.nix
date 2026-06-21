{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.boot;
  limit = 10;

  loaders = [
    "grub"
    "systemd-boot"
  ];
in
mkNixosModule {
  options.soul.boot = {
    loader = lib.mkOption {
      default = "systemd-boot";
      description = "The boot loader to use";
      type = lib.types.enum loaders;
    };
  };

  config.boot.loader = {
    efi = {
      canTouchEfiVariables = cfg.loader == "systemd-boot";
    };

    grub = {
      enable = cfg.loader == "grub";
      configurationLimit = limit;
      efiInstallAsRemovable = true;
      efiSupport = true;
    };

    systemd-boot = {
      enable = cfg.loader == "systemd-boot";
      configurationLimit = limit;
    };
  };
}
