{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix ./hardware-setup-bigmomma.nix ./private.nix];

 boot.loader.grub.enable = true;
 boot.loader.grub.version = 2;
 boot.loader.grub.device = "/dev/sda";

 networking = {
   hostName = "pesknix";
   networkmanager.enable = true;
   wireless.interfaces = [ "wlp3s0" ];
   wireless.userControlled.enable = true;
 };

 security.sudo.enable = true;
 security.polkit.enable = true;

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
   virtualbox.enableExtenstionPack = true;


 };

 hardware.pulseaudio.enable = true;
 hardware.pulseaudio.package = pkgs.pulseaudioFull;
 hardware.bluetooth.enable = true;

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
   networkmanagerapplet
   automake
   bash
   bc
   cabal-install
   chromium
   cmake
   cowsay
   ctags
   dmenu
   enlightenment.terminology
   fortune
   gcc
   gcolor2
   gdb
   git
   gnome3.nautilus
   gnumake
   go
   google-drive-ocamlfuse
   graphicsmagick
   shellcheck
   haskellPackages.cabal-install
   haskellPackages.cabal2nix
   haskellPackages.ghc
   haskellPackages.ghc-mod
   haskellPackages.hlint
   hicolor_icon_theme
   htop
   irssi
   liblapack
   libreoffice
   links2
   llvmPackages.clang
   llvmPackages.lldb
   lua
   manpages
   mplayer
   ncurses
   newsbeuter-dev
   nodejs
   nox
   nvim
   p7zip
   parted
   pavucontrol
   pkgconfig
   rsync
   ruby
   acpitool
   screen
   silver-searcher
   simplescreenrecorder
   slock
   slop
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
   zathura


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

(texlive.combine {
          inherit (texlive)
            collection-basic
            collection-bibtexextra
            collection-binextra
            collection-context
            collection-fontsextra
            collection-fontsrecommended
            collection-fontutils
            collection-formatsextra
            collection-games
            collection-genericextra
            collection-genericrecommended
            collection-htmlxml
            collection-humanities
            collection-langafrican
            collection-langarabic
            collection-langchinese
            collection-langcjk
            collection-langcyrillic
            collection-langczechslovak
            collection-langenglish
            collection-langeuropean
            collection-langfrench
            collection-langgerman
            collection-langgreek
            collection-langindic
            collection-langitalian
            collection-langjapanese
            collection-langkorean
            collection-langother
            collection-langpolish
            collection-langportuguese
            collection-langspanish
            collection-latex
            collection-latexextra
            collection-latexrecommended
            collection-luatex
            collection-mathextra
            collection-metapost
            collection-music
            collection-omega
            collection-pictures
            collection-plainextra
            collection-pstricks
            collection-publishers
            collection-science
            collection-texworks
            collection-wintools
            collection-xetex

            metafont;
        })

 ];

 services = {
   acpid.enable = true;
   acpid.handlers = {
     mute = { 
       action = "sudo -u andesil touch ~/HELLO"; 
       event = "button/mute.*"; 
       };
   };

   samba.enable = true;
   samba.securityType = "share";
   samba.extraConfig = ''
     workgroup = WORKGROUP
     server string = myServer
     netbios name = myServername
     #use sendfile = yes
     #max protocol = smb2
 
     interfaces = lo eth1 vboxnet0 vboxnet1
     bind interfaces only = yes
 
     [rw-files]
       comment = rw project files 
       path = /mnt/samba/
       read only = no
       writable = yes
       public = yes
       browsable = yes
   ''; 

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
     desktopManager.kde5.enable = true;
     displayManager = {
      sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
       slim = {
         enable = true;
         defaultUser = "andesil";
       };
     };
     };
   };

   environment.etc."profile.local".text = ''
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

   virtualisation.virtualbox.host.enable = true;


   users.extraUsers.andesil =
   { 
     isNormalUser = true;
     home = "/home/andesil";
     description = "Anders Sildnes";
     extraGroups = [ "netdev" "wheel" "networkmanager" "vboxusers" "audio" ];
   };

   sound.enableMediaKeys = true;

  system.stateVersion = "16.03";
}
