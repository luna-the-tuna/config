{
  config,
  lib,
  mkSystemModule,
  ...
}:
let
  inherit (config.soul) desktop;
in
mkSystemModule {
  shared.options.soul.desktop.enable = lib.mkOption {
    description = "Whether a desktop environment is enabled on this system.";
    readOnly = true;
    type = lib.types.bool;
  };

  darwin.config.soul.desktop = {
    enable = true;
  };

  nixos.config.soul.desktop = {
    enable = desktop.hyprland.enable;
  };
}
