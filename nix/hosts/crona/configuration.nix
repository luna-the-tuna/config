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
    inputs.extersia-pkgs.homeModules.default
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
    users.luna = ./home.nix;
  };

  age.secrets = {
    "passwords/luna".file = "${self}/nix/secrets/crona/passwords/luna.age";
    "passwords/root".file = "${self}/nix/secrets/crona/passwords/root.age";
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

  environment.systemPackages = [
    pkgs.qpwgraph
    pkgs.wiremix
  ];
}
