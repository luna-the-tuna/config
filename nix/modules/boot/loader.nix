{
  config,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.boot.loader;

  availableLoaders = [
    "grub"
    "systemd-boot"
  ];
in
mkNixosModule {
  options.soul.boot.loader = {
    program = lib.mkOption {
      default = "systemd-boot";
      description = "The boot loader program to use.";
      example = "grub";
      type = lib.types.enum availableLoaders;
    };

    limit = lib.mkOption {
      default = 10;
      description = "The maximum amount of configurations to show on the boot screen.";
      example = 67;
      type = lib.types.ints.between 1 100;
    };
  };

  config.boot.loader = {
    efi = {
      canTouchEfiVariables = cfg.program == "systemd-boot";
    };

    systemd-boot = {
      enable = cfg.program == "systemd-boot";
      configurationLimit = cfg.limit;
    };

    grub = {
      enable = cfg.program == "grub";
      configurationLimit = cfg.limit;
    };
  };
}
