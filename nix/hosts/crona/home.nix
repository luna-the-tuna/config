{ config, ... }:
{
  home = {
    stateVersion = config.home.version.release;
    preferXdgDirectories = true;
  };

  programs = {
    home-manager.enable = true;
  };
}
