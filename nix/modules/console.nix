{ mkNixosModule, ... }:
mkNixosModule {
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };
}
