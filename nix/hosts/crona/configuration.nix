{
  config,
  inputs,
  keys,
  pkgs,
  self,
  ...
}:
let
  homeModules = [
    inputs.agenix.homeManagerModules.default
    inputs.catppuccin.homeModules.default
    inputs.extersia-pkgs.homeModules.default
    inputs.spicetify.homeManagerModules.default
    inputs.zen-browser.homeModules.default
  ];
in
{
  soul.boot = {
    plymouth.enable = true;
  };

  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

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

  environment = {
    defaultPackages = [ ];
  };

  programs = {
    gamemode.enable = true;
    thunar.enable = true;
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.bashInteractive;
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets."passwords/luna".path;
    openssh.authorizedKeys.keys = keys.all;
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets."passwords/root".path;
    openssh.authorizedKeys.keys = keys.all;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    sharedModules = homeModules;
    extraSpecialArgs = { inherit self inputs; };

    users.luna = ./home.nix;
  };

  age.secrets = {
    "passwords/luna".file = "${self}/nix/secrets/crona/passwords/luna.age";
    "passwords/root".file = "${self}/nix/secrets/crona/passwords/root.age";
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
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

  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    crona = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.root;
    };
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.shells = [
    pkgs.nushell
  ];

  environment.systemPackages = [
    pkgs.gimp
    pkgs.kdePackages.kdenlive
    pkgs.qbittorrent
    pkgs.syncplay
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
  };
}
