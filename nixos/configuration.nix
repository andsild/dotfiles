{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix ./hardware-setup-bigmomma.nix ];

 boot.loader.grub.enable = true;
 boot.loader.grub.version = 2;
 boot.loader.grub.device = "/dev/sda";

 networking = {
   hostName = "pesknix";
   wireless.interfaces = [ "wlp3s0" ];
   wireless.userControlled.enable = true;
 };

 security.sudo.enable = true;
 security.sudo.wheelNeedsPassword = false;

 i18n = {
   consoleFont = "Lat2-Terminus16";
   consoleKeyMap = "us";
   defaultLocale = "en_US.UTF-8";
 };

 time.timeZone = "Europe/Oslo";

 nixpkgs.config = {
   allowUnfree = true;
   chromium = {
     enablePepperFlash = true; 
     enablePepperPDF = true;
   };
   firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
   };

 };

 hardware.pulseaudio.enable = true;

 fonts = {
   enableCoreFonts = true;
   enableFontDir = true;
   enableGhostscriptFonts = true;
   fonts = with pkgs; [
     dejavu_fonts
     inconsolata
   ];
 };

 environment.variables = rec {
   VISUAL  = "nvim";
   EDITOR  = VISUAL;
   BROWSER = "chromium-browser";
   SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
 };

 security.setuidPrograms = [ "slock" ];

 environment.systemPackages = 
 let
   nvim = pkgs.neovim.override {
     vimAlias = true;
   };
 in
 with pkgs; [
   automake
   bash
   bc
   cabal-install
   chromium
   clang
   cmake
   dmenu
   enlightenment.terminology
   gcc
   gcolor2
   gdb
   ghc
   git
   gnumake
   go
   haskellPackages.ghc-mod
   haskellPackages.hlint
   irssi
   liblapack
   libreoffice
   links2
   llvmPackages.clang-unwrapped
   lua
   manpages
   mplayer
   ncurses
   newsbeuter-dev
   nodejs
   nvim
   rsync
   ruby
   screen
   silver-searcher
   slock
   sqlite
   tree
   vlc
   wget
   workrave
   xclip
   xfontsel
   xlsfonts
   xorg.xev
   xscreensaver

   python
   python3
   pythonPackages.virtualenv
   python3Packages.virtualenv
   pythonPackages.pip
   python3Packages.pip
   pythonPackages.ipython
   python3Packages.ipython
   pythonPackages.pip
   python3Packages.pip

 ];

 services = {
   openssh.enable = true;
   locate.enable = true;
   printing.enable = true;

   xserver = {
     enable = true;
     layout = "us";
     xkbOptions = "eurosign:e";
     windowManager.wmii.enable = true;
     windowManager.xmonad.enable = true;
     windowManager.xmonad.enableContribAndExtras = true;
     displayManager = {
       slim = {
         enable = true;
         defaultUser = "andesil";
       };
     };
     };
   };

   environment.etc."profile.local".text = ''
   echo "SOURCED!
   if [ -e "$HOME/.bash_profile" ]
   then
   source "$HOME/.bash_profile"
   fi
   '';


   environment.etc."inputrc".text = ''
   set visible-stats on

   # set editing-mode vi
   $if mode=vi

   set blink-matching-paren on

   # Lines below specify for command mode
   set keymap vi-command
   "P":yank-last-arg
   "p":yank-last-arg

   Control-l: clear-screen

   # Command in insert mode
   set keymap vi-insert
   Control-l: clear-screen
   "\e[A": history-search-backward

   "jj": vi-movement-mode
   "\C-w": backward-kill-word
   "\C-p": history-search-backward
   $endif

   set completion-ignore-case on
   '';

   programs = {
     bash.enableCompletion = true; 
     ssh.startAgent = true;    
   };


   users.extraUsers.andesil =
   { 
     isNormalUser = true;
     home = "/home/andesil";
     description = "Anders Sildnes";
     extraGroups = [ "wheel" "networkmanager" "vboxusers" "audio" ];
   };

  system.stateVersion = "16.03";
}
