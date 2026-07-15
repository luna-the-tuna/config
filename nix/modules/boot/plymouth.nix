{
  config,
  lib,
  mkNixosModule,
  pkgs,
  self,
  ...
}:
let
  cfg = config.soul.boot.plymouth;
  theme = pkgs.soul.plymouth-gif-theme.override { inherit (cfg) gif fps; };
in
mkNixosModule {
  options.soul.boot.plymouth = {
    enable = lib.mkOption {
      default = false;
      description = "Whether to show a custom GIF on the boot loader screen.";
      type = lib.types.bool;
    };

    gif = lib.mkOption {
      default = "${self}/assets/gifs/crona-and-maka.gif";
      description = "The GIF to show on the boot loader screen.";
      example = ./my/custom/logo.gif;
      type = lib.types.path;
    };

    fps = lib.mkOption {
      default = 16;
      description = "The FPS of the custom GIF.";
      example = 30;
      type = lib.types.ints.between 8 64;
    };
  };

  config.boot = lib.mkIf cfg.enable {
    consoleLogLevel = 0;
    initrd.verbose = false;
    loader.timeout = 0;

    plymouth = {
      enable = true;
      theme = theme.pname;
      themePackages = [ theme ];
    };

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };
}
