{ mkNixosModule, ... }:
mkNixosModule {
  hardware.enableRedistributableFirmware = true;
}
