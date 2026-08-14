{ config, mkNixosModule, ... }:
mkNixosModule {
  networking.networkmanager.enable = config.soul.desktop.enable;
}
