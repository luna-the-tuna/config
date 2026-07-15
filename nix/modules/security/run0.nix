{ mkNixosModule, ... }:
mkNixosModule {
  security.run0 = {
    enable = true;
    sudo-shim.enable = true;
  };
}
