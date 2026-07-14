{ config, ... }:
let
  inherit (config.home) homeDirectory;
in
{
  home = {
    stateVersion = config.home.version.release;
    preferXdgDirectories = true;
  };

  programs = {
    home-manager.enable = true;
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${homeDirectory}/desktop";
    documents = "${homeDirectory}/documents";
    download = "${homeDirectory}/downloads";
    music = "${homeDirectory}/music";
    pictures = "${homeDirectory}/pictures";
    projects = "${homeDirectory}/projects";
    publicShare = "${homeDirectory}/public";
    templates = "${homeDirectory}/templates";
    videos = "${homeDirectory}/videos";
  };
}
