{
  self,
  inputs,
  config,
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

  programs.git.enable = true;
  programs.neovim.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.users.luna = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
}
