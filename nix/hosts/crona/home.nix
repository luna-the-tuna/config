{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;
  palette = lib.importJSON "${inputs.catppuccin-palette}/palette.json";
in
{
  _module.args = {
    inherit (lib.getAttr config.catppuccin.flavor palette) colors;
  };

  home = {
    stateVersion = config.home.version.release;
    preferXdgDirectories = true;
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";

    mpv.enable = false;
    sources.palette = inputs.catppuccin-palette;
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
