{ pkgs, mkNixosModule, ... }:
mkNixosModule {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.bashInteractive;
  };
}
