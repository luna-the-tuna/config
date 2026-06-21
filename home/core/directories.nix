{ config, pkgs, ... }:
let
  home = config.home.homeDirectory;
in
{
  xdg.userDirs = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    createDirectories = true;

    desktop = "${home}/desktop";
    documents = "${home}/documents";
    download = "${home}/download";
    music = "${home}/music";
    pictures = "${home}/pictures";
    projects = "${home}/projects";
    publicShare = "${home}/public";
    templates = "${home}/templates";
    videos = "${home}/videos";
  };
}
