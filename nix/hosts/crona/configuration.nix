{ inputs, pkgs, ... }:
{
  soul.boot = {
    plymouth.enable = true;
  };

  soul.home = {
    imports = [ ./home.nix ];
  };

  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

  soul.users.accounts.luna = {
    firstName = "Luna";
    lastName = "Heyman";
    email = "contact@luna.fish";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
  };

  soul.packages = [
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.qbittorrent

    (pkgs.syncplay.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        repo = "syncplay";
        owner = "Syncplay";
        rev = "578b7b9ea25b505a645219cc7e4b755b728b8efe";
        hash = "sha256-1GM3KTwC7kngtsdMCLRepubkOyuM7bXDpWoQTeuzB3M=";
      };
    })
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";

    plymouth.enable = false;
    sources.palette = inputs.catppuccin-palette;
  };

  fonts = {
    enableDefaultPackages = false;
  };

  programs = {
    gamemode.enable = true;
    thunar.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.obs-studio = {
    enable = true;

    plugins = [
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.obs-studio-plugins.obs-vaapi
    ];
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.shells = [
    pkgs.nushell
  ];

  fonts.packages = [
    pkgs.maple-mono.NF
    pkgs.montserrat
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts.monospace = [
      "Maple Mono NF"
    ];

    defaultFonts.emoji = [
      "Noto Color Emoji"
    ];

    defaultFonts.serif = [
      "Noto Serif"
      "Noto Cjk Serif"
    ];

    defaultFonts.sansSerif = [
      "Work Sans"
      "Noto Cjk Sans"
    ];

    localConf = ''
      <alias>
        <family>system-ui</family>
        <prefer><family>sans-serif</family></prefer>
      </alias>
    '';
  };
}
