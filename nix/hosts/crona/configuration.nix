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
  system = {
    stateVersion = config.system.nixos.release;
    configurationRevision = self.rev or self.dirtRev or null;
    disableInstallerTools = true;
  };

  system.tools = {
    nixos-rebuild.enable = true;
    nixos-version.enable = true;
  };

  time = {
    timeZone = "Europe/Brussels";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "nl_BE.UTF-8/UTF-8" ];
  };

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  boot.loader = {
    timeout = 0;
    efi.canTouchEfiVariables = true;
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  boot.plymouth = {
    enable = true;
    theme = pkgs.soul.plymouth-gif-theme.pname;
    themePackages = [ pkgs.soul.plymouth-gif-theme ];
  };

  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];

  nix = {
    channel.enable = false;
    optimise.automatic = true;
  };

  nix.settings = {
    keep-going = true;
    keep-outputs = true;
    keep-derivations = true;

    use-xdg-base-directories = true;
    warn-dirty = false;

    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];

    experimental-features = [
      "flakes"
      "lix-custom-sub-commands"
      "nix-command"
      "pipe-operator"
    ];
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";

    plymouth.enable = false;
    sources.palette = inputs.catppuccin-palette;
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = "Defaults env_reset,pwfeedback";
  };

  networking = {
    useNetworkd = true;
  };

  console = {
    earlySetup = true;
    useXkbConfig = true;
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

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.pipewire = {
    enable = true;
    jack.enable = true;
    pulse.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    configPackages = [
      pkgs.soul.pipewire-quantum
      pkgs.soul.pipewire-rnnoise
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
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
    pkgs.qpwgraph
    pkgs.syncplay
    pkgs.wiremix
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
