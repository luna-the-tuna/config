{ mkNixosModule, ... }:
mkNixosModule {
  console = {
    useXkbConfig = true;
  };

  services.xserver.xkb = {
    layout = "us";
    options = "eurosign:e,caps:escape";
  };
}
