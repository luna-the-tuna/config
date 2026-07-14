{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
in
{
  home = {
    stateVersion = config.home.version.release;
    preferXdgDirectories = true;
  };

  programs = {
    carapace.enable = true;
    home-manager.enable = true;
    nix-your-shell.enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nushell = {
    enable = true;
    settings.show_banner = false;
  };

  programs.bash = {
    enable = true;
    initExtra = lib.mkOrder 2000 "exec ${lib.getExe pkgs.nushell}";
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
