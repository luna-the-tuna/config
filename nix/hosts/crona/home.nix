{
  colors,
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  self,
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
    vesktop.enable = true;
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

  programs.spicetify = {
    enable = true;
    theme = pkgs.spicePackages.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
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

  wayland.windowManager.hyprland = with self.lib.hypr; {
    enable = true;
    package = osConfig.programs.hyprland.package;

    settings.config = {
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

    settings.window_rule = [
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

    settings.animation = [
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

    settings.env = [
      (mkEnv "DISPLAY" ":2")
      (mkEnv "XCURSOR_SIZE" (toString config.home.pointerCursor.size))
      (mkEnv "HYPRCURSOR_SIZE" (toString config.home.pointerCursor.size))
    ];

    settings.bind = [
      (mkKeyBind "SUPER + RETURN" ''hl.dsp.exec_cmd("${lib.getExe pkgs.kitty}")'')
      (mkKeyBind "SUPER + SPACE" ''hl.dsp.exec_cmd("${lib.getExe pkgs.rofi} -show drun")'')
      (mkKeyBind "SUPER + B" ''hl.dsp.exec_cmd("${lib.getExe pkgs.zen-browser}")'')
      (mkKeyBind "SUPER + S" ''hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} --mode region --clipboard-only")'')
      (mkKeyBind "SUPER + C" ''hl.dsp.exec_cmd("${lib.getExe pkgs.hyprpicker} | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}")'')

      (mkKeyBind "SUPER + Q" "hl.dsp.window.close()")
      (mkKeyBind "SUPER + SHIFT +Q" "hl.dsp.exit()")

      (mkKeyBind "SUPER + F" ''hl.dsp.window.float({ action = "toggle" })'')
      (mkKeyBind "SUPER + SHIFT + F" ''hl.dsp.window.fullscreen({ action = "toggle" })'')

      (mkKeyBind "SUPER + H" ''hl.dsp.focus({ direction = "l" })'')
      (mkKeyBind "SUPER + J" ''hl.dsp.focus({ direction = "d" })'')
      (mkKeyBind "SUPER + K" ''hl.dsp.focus({ direction = "u" })'')
      (mkKeyBind "SUPER + L" ''hl.dsp.focus({ direction = "r" })'')

      (mkKeyBind "SUPER + SHIFT + H" ''hl.dsp.window.move({ direction = "l" })'')
      (mkKeyBind "SUPER + SHIFT + J" ''hl.dsp.window.move({ direction = "d" })'')
      (mkKeyBind "SUPER + SHIFT + K" ''hl.dsp.window.move({ direction = "u" })'')
      (mkKeyBind "SUPER + SHIFT + L" ''hl.dsp.window.move({ direction = "r" })'')

      (mkKeyBind "SUPER + 1" ''hl.dsp.focus({ workspace = "1" })'')
      (mkKeyBind "SUPER + 2" ''hl.dsp.focus({ workspace = "2" })'')
      (mkKeyBind "SUPER + 3" ''hl.dsp.focus({ workspace = "3" })'')
      (mkKeyBind "SUPER + 4" ''hl.dsp.focus({ workspace = "4" })'')
      (mkKeyBind "SUPER + 5" ''hl.dsp.focus({ workspace = "5" })'')
      (mkKeyBind "SUPER + 6" ''hl.dsp.focus({ workspace = "6" })'')
      (mkKeyBind "SUPER + 7" ''hl.dsp.focus({ workspace = "7" })'')
      (mkKeyBind "SUPER + 8" ''hl.dsp.focus({ workspace = "8" })'')
      (mkKeyBind "SUPER + 9" ''hl.dsp.focus({ workspace = "9" })'')
      (mkKeyBind "SUPER + 0" ''hl.dsp.focus({ workspace = "10" })'')
      (mkKeyBind "ALT + TAB" ''hl.dsp.focus({ workspace = "previous" })'')

      (mkKeyBind "SUPER + SHIFT + 1" ''hl.dsp.window.move({ workspace = "1" })'')
      (mkKeyBind "SUPER + SHIFT + 2" ''hl.dsp.window.move({ workspace = "2" })'')
      (mkKeyBind "SUPER + SHIFT + 3" ''hl.dsp.window.move({ workspace = "3" })'')
      (mkKeyBind "SUPER + SHIFT + 4" ''hl.dsp.window.move({ workspace = "4" })'')
      (mkKeyBind "SUPER + SHIFT + 5" ''hl.dsp.window.move({ workspace = "5" })'')
      (mkKeyBind "SUPER + SHIFT + 6" ''hl.dsp.window.move({ workspace = "6" })'')
      (mkKeyBind "SUPER + SHIFT + 7" ''hl.dsp.window.move({ workspace = "7" })'')
      (mkKeyBind "SUPER + SHIFT + 8" ''hl.dsp.window.move({ workspace = "8" })'')
      (mkKeyBind "SUPER + SHIFT + 9" ''hl.dsp.window.move({ workspace = "9" })'')
      (mkKeyBind "SUPER + SHIFT + 0" ''hl.dsp.window.move({ workspace = "10" })'')

      (mkMouseBind "SUPER + mouse:272" "hl.dsp.window.drag()")
      (mkMouseBind "SUPER + mouse:273" "hl.dsp.window.resize()")
    ];

    settings.curve = [
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

    settings.on = [
      (mkHandler "hyprland.start" ''
        function()
          hl.exec_cmd("${lib.getExe pkgs.xwayland-satellite} :2")
        end
      '')
    ];
  };
}
