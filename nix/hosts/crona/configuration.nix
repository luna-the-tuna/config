{ pkgs, ... }:
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

  soul.desktop = {
    hyprland.enable = true;
  };

  soul.packages = [
    pkgs.crosspatch
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.qbittorrent
    pkgs.syncplay
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];

  fonts = {
    enableDefaultPackages = false;
  };

  programs = {
    gamemode.enable = true;
    pmount.enable = true;
    thunar.enable = true;
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
