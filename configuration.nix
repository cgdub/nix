# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;

    chromium = {
      enablePepperFlash = true;
      gnomeSupport = true;
      gnomeKeyringSupport = true;
    };
  };

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nomodeset" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    binutils
    chromium
    dmenu
    emacs
    firefox
    gitAndTools.gitFull
    haskellPackages.xmobar
    haskellPackages.xmonad
    iptables
    manpages
    nix
    nmap
    rxvt_unicode
    steam
    tcpdump
    vim
    wget
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.s3tcSupport = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.autorun = true;
  # services.xserver.exportConfiguration = true;
  services.xserver.enableCtrlAltBackspace = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.displayManager.slim.defaultUser = "chris";

  services.nixosManual.showManual = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.chris = {
    isNormalUser = true;
    home = "/home/chris";
    description = "Chris W";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
