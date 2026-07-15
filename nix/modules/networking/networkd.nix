{ mkNixosModule, ... }:
mkNixosModule {
  networking.useNetworkd = true;
}
