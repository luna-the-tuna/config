{
  self,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default

    ./hardware-configuration.nix
    ./disk-configuration.nix
  ];

  system.stateVersion = "26.11";
  networking.hostName = "crona";

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  console.useXkbConfig = true;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.openssh.enable = true;
  services.blueman.enable = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  fonts.enableDefaultPackages = false;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    extraLadspaPackages = [
      pkgs.rnnoise-plugin.ladspa
    ];

    extraConfig.pipewire."10-quantum" = {
      "context.properties"."default.clock.min-quantum" = 1024;
    };

    extraConfig.pipewire."99-rnnoise" = {
      "context.modules" = lib.singleton {
        name = "libpipewire-module-filter-chain";

        args = {
          "node.description" = "Noise cancelling source";
          "media.name" = "Noise cancelling source";

          "filter.graph".nodes = lib.singleton {
            type = "ladspa";
            name = "rnnoise";
            label = "noise_suppressor_mono";
            plugin = "librnnoise_ladspa";

            control = {
              "VAD Threshold (%)" = 95;
              "VAD Grace Period (ms)" = 200;
              "Retroactive VAD Grace (ms)" = 0;
            };
          };

          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "audio.rate" = 48000;
          };

          "playback.props" = {
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
        };
      };
    };
  };

  users.users.luna = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    packages = [
      pkgs.wiremix
    ];
  };

  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "mocha";
    accent = "mauve";

    sources.palette = inputs.catppuccin-palette;
    plymouth.enable = false;
  };

  nix = {
    channel.enable = false;
    gc.automatic = true;
    optimise.automatic = true;

    settings = {
      warn-dirty = false;
      use-xdg-base-directories = true;

      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "lix-custom-sub-commands"
        "flakes"
        "pipe-operator"
        "nix-command"
      ];

      deprecated-features = [
        "broken-string-indentation"
      ];
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    extraSpecialArgs = { inherit self inputs; };

    users.luna = ./home.nix;
  };

  fonts.packages = [
    pkgs.maple-mono.NF
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "Maple Mono NF" ];
      emoji = [ "Noto Color Emoji" ];

      serif = [
        "Noto Serif"
        "Noto Cjk Serif"
      ];

      sansSerif = [
        "Work Sans"
        "Noto Cjk Sans"
      ];
    };
  };
}
