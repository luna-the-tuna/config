{ mkNixosModule, ... }:
mkNixosModule {
  programs.nh = {
    enable = true;
    clean.enable = true;
  };
}
