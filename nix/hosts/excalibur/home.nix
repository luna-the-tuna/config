{
  colors,
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  home.shellAliases = {
    cat = lib.getExe pkgs.bat;
    lf = lib.getExe pkgs.yazi;
  };

  programs = {
    bat.enable = true;
    carapace.enable = true;
    lazygit.enable = true;
    nix-your-shell.enable = true;
    opencode.enable = true;
    vesktop.enable = true;
    yazi.enable = true;
  };

  programs.spicetify = {
    enable = true;
    theme = pkgs.spicePackages.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    nixpkgs.source = inputs.nixpkgs;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nushell = {
    inherit (config.home) shellAliases;
    enable = true;
    settings.show_banner = false;
  };

  programs.bash = {
    enable = true;
    initExtra = lib.mkOrder 2000 "exec ${lib.getExe pkgs.nushell}";
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
  };

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      name = "Default";
      isDefault = true;
      containersForce = true;
      spacesForce = true;
      pinsForce = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "extensions.autoDisableScopes" = false;
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "zen.urlbar.replace-newtab" = false;
        "zen.view.compact.enable-at-startup" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
      };

      search = {
        force = true;
        default = "ddg";
      };

      extensions = {
        force = true;

        packages = with pkgs.firefox-addons; [
          catppuccin-web-file-icons
          proton-pass
          return-youtube-dislikes
          shinigami-eyes
          sponsorblock
          stylus
          tablissng
          ublock-origin
          yomitan
          youtube-shorts-block
        ];
      };

      bookmarks = {
        force = true;

        settings = [
          {
            name = "Toolbar";
            toolbar = true;

            bookmarks = [
              {
                name = "Productive";
                url = "https://app.productive.io";
              }
            ];
          }
        ];
      };

      containers.default = {
        color = "purple";
        icon = "fingerprint";
        id = 1;
      };

      spaces.default = {
        id = "13a3da61-48c4-4d49-8166-174419b311a7";
        position = 1000;
        container = config.programs.zen-browser.profiles.default.containers.default.id;

        theme.colors = lib.singleton {
          red = colors.base.rgb.r;
          green = colors.base.rgb.g;
          blue = colors.base.rgb.b;
        };
      };
    };
  };
}
