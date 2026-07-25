{
  colors,
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:
{
  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.shellAliases = {
    cat = lib.getExe pkgs.bat;
    lf = lib.getExe pkgs.yazi;
  };

  programs = {
    bat.enable = true;
    carapace.enable = true;
    lazygit.enable = true;
    nix-your-shell.enable = true;
    vesktop.enable = true;
    yazi.enable = true;
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

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = 0.95;
      confirm_os_window_close = 0;

      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
    };
  };

  programs.spicetify = {
    enable = true;
    theme = pkgs.spicePackages.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
  };

  programs.zed-editor = {
    enable = true;
    mutableUserDebug = false;
    mutableUserKeymaps = false;
    mutableUserSettings = false;
    mutableUserTasks = false;

    userSettings = {
      vim_mode = true;
      ui_font_family = "Work Sans";
      buffer_font_family = "Maple Mono NF";
    };

    extensions = [
      "just"
      "nix"
      "toml"
    ];

    extraPackages = [
      pkgs.just-lsp
      pkgs.nixd
    ];
  };

  programs.mpv = {
    enable = true;

    scripts = [
      pkgs.mpvScripts.modernz
      pkgs.mpvScripts.thumbfast
    ];

    config = {
      ao = "pulse";
      osc = "no";
      target-colorspace-hint = "no";
    };

    scriptOpts.modernz = {
      icon_theme = "material";
    };
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
                name = "YouTube";
                url = "https://www.youtube.com";
              }
              {
                name = "Music";
                url = "https://music.youtube.com";
              }
              "separator"
              {
                name = "Mail";
                url = "https://mail.proton.me";
              }
              {
                name = "Calendar";
                url = "https://calendar.proton.me";
              }
              {
                name = "Drive";
                url = "https://drive.proton.me";
              }
              "separator"
              {
                name = "GitHub";
                url = "https://github.com";
              }
              {
                name = "Tangled";
                url = "https://tangled.org";
              }
              "separator"
              {
                name = "Letterboxd";
                url = "https://letterboxd.com";
              }
              {
                name = "MAL";
                url = "https://myanimelist.net";
              }
              {
                name = "Backloggd";
                url = "https://backloggd.com";
              }
              {
                name = "AOTY";
                url = "https://www.albumoftheyear.org";
              }
              "separator"
              {
                name = "ProtonDB";
                url = "https://www.protondb.com";
              }
              "separator"
              {
                name = "Nix";

                bookmarks = [
                  {
                    name = "Nix.ee";
                    url = "https://nix.ee";
                  }
                  {
                    name = "Search";
                    url = "https://search.nix.ee";
                  }
                  {
                    name = "Docs";
                    url = "https://docs.nix.ee";
                  }
                ];
              }
              {
                name = "Dles";

                bookmarks = [
                  {
                    name = "Raddle";
                    url = "https://raddle.quest";
                  }
                  {
                    name = "Connections";
                    url = "https://www.nytimes.com/games/connections";
                  }
                  {
                    name = "Framed";
                    url = "https://framed.wtf";
                  }
                  {
                    name = "Box-office Game";
                    url = "https://boxofficega.me";
                  }
                  {
                    name = "Scrandle";
                    url = "https://scrandle.com";
                  }
                ];
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

  xdg.dataFile."kdenlive/export/customprofiles.xml" = {
    source = "${self}/config/kdenlive/custom-export-profiles.xml";
  };

  xdg.configFile."quickshell.json".text = builtins.toJSON {
    wallpaper = "${self}/assets/wallpapers/catppuccin-blossoms.png";
    colors = lib.mapAttrs (name: value: value.hex) colors;
  };
}
