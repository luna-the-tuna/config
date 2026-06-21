{
  colors,
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  user,
  ...
}:
let
  palette =
    "${config.catppuccin.sources.palette}/palette.json"
    |> lib.importJSON
    |> lib.getAttr config.catppuccin.flavor;
in
{
  imports = [
    inputs.catppuccin.homeModules.default
    inputs.nixvim.homeModules.default
    inputs.spicetify.homeManagerModules.default
    inputs.zen-browser.homeModules.default
  ];

  _module.args = { inherit (palette) colors; };

  catppuccin = {
    inherit (osConfig.catppuccin)
      autoEnable
      enable
      flavor
      accent
      ;
    sources = { inherit (osConfig.catppuccin.sources) palette; };
    mpv.enable = false;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  home.shellAliases = {
    q = "exit";
    cat = lib.getExe pkgs.bat;
    lf = lib.getExe pkgs.yazi;
  };

  programs.vesktop.enable = true;
  programs.bat.enable = true;
  programs.yazi.enable = true;
  programs.nix-your-shell.enable = true;

  programs.spicetify = {
    enable = true;
    theme = pkgs.spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.nushell = {
    enable = true;
    shellAliases = config.home.shellAliases;

    settings = {
      show_banner = false;
    };
  };

  programs.bash = {
    enable = true;
    initExtra = lib.mkOrder 2000 ''exec "${lib.getExe pkgs.nushell}"'';
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

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    };

    settings = {
      core.ignorecase = true;
      pull.rebase = true;
      init.defaultBranch = "main";

      user = {
        name = user.fullName;
        email = user.email;
      };

      alias = {
        lga = "log --decorate --oneline --graph";
        put = "push --set-upstream";
        ui = "!${lib.getExe pkgs.lazygit}";
      };
    };
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
        "extensions.autoDisableScopes" = false;
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "zen.urlbar.replace-newtab" = true;
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
          ublock-origin
          yomitan
          youtube-shorts-block
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

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    useGlobalPkgs = true;

    imports = [
      ./neovim.nix
      {
        _module.args = {
          inherit osConfig;
          homeConfig = config;
        };
      }
    ];
  };

  wayland.windowManager.hyprland =
    let
      mkBind = keys: command: {
        _args = [
          keys
          (lib.generators.mkLuaInline command)
        ];
      };

      mkMouseBind = buttons: command: {
        _args = [
          buttons
          (lib.generators.mkLuaInline command)
          { mouse = true; }
        ];
      };

      mkEnv = key: value: {
        _args = [
          key
          value
        ];
      };

      mkCurve = name: points: {
        _args = [
          name
          {
            inherit points;
            type = "bezier";
          }
        ];
      };
    in
    {
      inherit (osConfig.programs.hyprland) enable package;

      settings = {
        config = {
          general = {
            layout = "master";

            gaps_in = 5;
            gaps_out = 10;

            border_size = 2;
            resize_on_border = true;

            "col.active_border" = lib.generators.mkLuaInline "colors.mauve";
            "col.inactive_border" = lib.generators.mkLuaInline "colors.overlay0";
          };

          decoration = {
            rounding = 6;
            rounding_power = 3;

            blur = {
              enabled = true;
              passes = 2;
              size = 5;
              vibrancy = 0.15;
            };

            shadow = {
              enabled = true;
              range = 6;
              render_power = 3;
              color = lib.generators.mkLuaInline ''"rgba(" .. colors.crustAlpha .. "aa)"'';
            };
          };

          input = {
            kb_layout = osConfig.services.xserver.xkb.layout;
            kb_options = osConfig.services.xserver.xkb.options;

            sensitivity = 0;
            follow_mouse = true;

            touchpad.natural_scroll = true;
          };

          misc = {
            disable_hyprland_logo = true;
            force_default_wallpaper = false;
          };

          animations = {
            enabled = true;
          };
        };

        window_rule = [
          {
            name = "suppress-maximize-events";
            suppress_event = "maximize";
            match.class = ".*";
          }
          {
            name = "fix-xwayland-drags";
            no_focus = true;

            match.class = "^$";
            match.title = "^$";
            match.float = true;
            match.fullscreen = false;
            match.pin = false;
            match.xwayland = true;
          }
        ];

        animation = [
          {
            enabled = true;
            speed = 5;
            leaf = "global";
            bezier = "default";
          }
          {
            enabled = true;
            speed = 4;
            leaf = "border";
            bezier = "easeOut";
          }
          {
            enabled = true;
            leaf = "fade";
            speed = 4;
            bezier = "easeOut";
          }
          {
            enabled = true;
            leaf = "windows";
            speed = 4;
            bezier = "easeOut";
          }
          {
            enabled = true;
            leaf = "windowsIn";
            speed = 4;
            bezier = "easeOut";
            style = "slide bottom";
          }
          {
            enabled = true;
            leaf = "windowsOut";
            speed = 4;
            bezier = "easeOut";
            style = "gnomed";
          }
          {
            enabled = true;
            leaf = "workspaces";
            bezier = "easeInOut";
            speed = 1.9;
          }
          {
            enabled = true;
            leaf = "workspacesIn";
            bezier = "easeInOut";
            speed = 1.9;
            style = "slide";
          }
          {
            enabled = true;
            leaf = "workspacesOut";
            bezier = "easeInOut";
            speed = 1.9;
            style = "slide";
          }
        ];

        env = [
          (mkEnv "DISPLAY" ":2")
          (mkEnv "XCURSOR_SIZE" (toString config.home.pointerCursor.size))
          (mkEnv "HYPRCURSOR_SIZE" (toString config.home.pointerCursor.size))
        ];

        bind = [
          (mkBind "SUPER + RETURN" ''hl.dsp.exec_cmd("${lib.getExe pkgs.kitty}")'')
          (mkBind "SUPER + SPACE" ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -show drun")'')
          (mkBind "SUPER + B" ''hl.dsp.exec_cmd("${lib.getExe pkgs.zen-browser}")'')
          (mkBind "SUPER + S" ''hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} --mode region --clipboard-only")'')
          (mkBind "SUPER + C" ''hl.dsp.exec_cmd("${lib.getExe pkgs.hyprpicker} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}")'')

          (mkBind "SUPER + Q" "hl.dsp.window.close()")
          (mkBind "SUPER + SHIFT +Q" "hl.dsp.exit()")

          (mkBind "SUPER + F" ''hl.dsp.window.float({ action = "toggle" })'')
          (mkBind "SUPER + SHIFT + F" ''hl.dsp.window.fullscreen({ action = "toggle" })'')

          (mkBind "SUPER + H" ''hl.dsp.focus({ direction = "l" })'')
          (mkBind "SUPER + J" ''hl.dsp.focus({ direction = "d" })'')
          (mkBind "SUPER + K" ''hl.dsp.focus({ direction = "u" })'')
          (mkBind "SUPER + L" ''hl.dsp.focus({ direction = "r" })'')

          (mkBind "SUPER + SHIFT + H" ''hl.dsp.window.move({ direction = "l" })'')
          (mkBind "SUPER + SHIFT + J" ''hl.dsp.window.move({ direction = "d" })'')
          (mkBind "SUPER + SHIFT + K" ''hl.dsp.window.move({ direction = "u" })'')
          (mkBind "SUPER + SHIFT + L" ''hl.dsp.window.move({ direction = "r" })'')

          (mkBind "SUPER + 1" ''hl.dsp.focus({ workspace = "1" })'')
          (mkBind "SUPER + 2" ''hl.dsp.focus({ workspace = "2" })'')
          (mkBind "SUPER + 3" ''hl.dsp.focus({ workspace = "3" })'')
          (mkBind "SUPER + 4" ''hl.dsp.focus({ workspace = "4" })'')
          (mkBind "SUPER + 5" ''hl.dsp.focus({ workspace = "5" })'')
          (mkBind "SUPER + 6" ''hl.dsp.focus({ workspace = "6" })'')
          (mkBind "SUPER + 7" ''hl.dsp.focus({ workspace = "7" })'')
          (mkBind "SUPER + 8" ''hl.dsp.focus({ workspace = "8" })'')
          (mkBind "SUPER + 9" ''hl.dsp.focus({ workspace = "9" })'')
          (mkBind "SUPER + 0" ''hl.dsp.focus({ workspace = "10" })'')
          (mkBind "ALT + TAB" ''hl.dsp.focus({ workspace = "previous" })'')

          (mkBind "SUPER + SHIFT + 1" ''hl.dsp.window.move({ workspace = "1" })'')
          (mkBind "SUPER + SHIFT + 2" ''hl.dsp.window.move({ workspace = "2" })'')
          (mkBind "SUPER + SHIFT + 3" ''hl.dsp.window.move({ workspace = "3" })'')
          (mkBind "SUPER + SHIFT + 4" ''hl.dsp.window.move({ workspace = "4" })'')
          (mkBind "SUPER + SHIFT + 5" ''hl.dsp.window.move({ workspace = "5" })'')
          (mkBind "SUPER + SHIFT + 6" ''hl.dsp.window.move({ workspace = "6" })'')
          (mkBind "SUPER + SHIFT + 7" ''hl.dsp.window.move({ workspace = "7" })'')
          (mkBind "SUPER + SHIFT + 8" ''hl.dsp.window.move({ workspace = "8" })'')
          (mkBind "SUPER + SHIFT + 9" ''hl.dsp.window.move({ workspace = "9" })'')
          (mkBind "SUPER + SHIFT + 0" ''hl.dsp.window.move({ workspace = "10" })'')

          (mkMouseBind "SUPER + mouse:272" "hl.dsp.window.drag()")
          (mkMouseBind "SUPER + mouse:273" "hl.dsp.window.resize()")
        ];

        curve = [
          (mkCurve "linear" [
            [
              0
              0
            ]
            [
              1
              1
            ]
          ])
          (mkCurve "easeOut" [
            [
              0.23
              1
            ]
            [
              0.32
              1
            ]
          ])
          (mkCurve "easeInOut" [
            [
              0.28
              0.09
            ]
            [
              0.59
              1
            ]
          ])
        ];

        on._args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("${lib.getExe pkgs.xwayland-satellite} :2")
            end
          '')
        ];
      };
    };
}
