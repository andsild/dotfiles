{ config, lib, pkgs, ... }:

let
  phpSockName1 = "/run/phpfpm/pool1.sock";
  username = "andsild";
  homedir = "/home/" + username + "/";
  concat = l: r: l + r;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./private.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    extraHosts = ''
    # I'm addicted, got to stop going there
    127.0.0.1 www.9gag.com
    127.0.0.1 9gag.com
    127.0.0.1 www.imgur.com
    127.0.0.1 imgur.com
    '';

    firewall = {
      enable = true;
      allowPing = false;

      connectionTrackingModules = [];
      autoLoadConntrackHelpers = false;
    };
  };

  security.sudo.enable = true;
  security.polkit.enable = true;
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "524288";
  }
  # Changing the hard limits in PAM can disable your login shell for root and regular users.
  # Before experimenting with changes, I recommend having a logged in sessions as root so that you can rollback changes
  # (To test live without rebooting, open new sessions with `su - $(id -un)`)
  {
    domain = "*";
    type = "hard";
    item = "nofile";
    value = "16192";
  }
  ];
  
  security.wrappers = {
    slock = {
      source = "${pkgs.slock.out}/bin/slock";
      owner = "root";
      group = "root";
      setuid = true;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };


  time.timeZone = "Europe/Oslo";

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      inconsolata
    ];
  };

  environment.shellInit = ''
    # gpg-connect-agent /bye
    # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services = {
      openssh = {
        enable = true;
        permitRootLogin = "no";
        passwordAuthentication = true;
        challengeResponseAuthentication = true;
      };
      locate.enable = false;
      locate.localuser = username;
      locate.prunePaths = ["/tmp" "/var/tmp" "/proc" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/mnt" "/opt" "/boot" "/var/lib/docker" "/lost+found"];

      clamav.daemon.enable = true;
      clamav.updater.enable = true;
      clamav.updater.frequency = 1;

      udev.packages = with pkgs; [ yubikey-personalization ];

      blueman.enable = true;

    xserver = {
      enable = true;
      # setxkbmap  -option eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no
      layout = "us,no";
      xkbOptions = "eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no";
      windowManager.wmii.enable = true;
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      windowManager.xmonad.extraPackages = with pkgs.haskellPackages; haskellPackages: [ xmobar ];
      displayManager = {
        sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
        gdm = {
          enable = true;
        };
      };
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };


 environment.extraInit = ''
xdg-mime default zathura.desktop application/pdf
xdg-mime default qutebrowser.desktop text/html
xdg-mime default shotwell.desktop image/jpeg
xdg-mime default shotwell.desktop image/jpg
xdg-mime default shotwell.desktop image/png
xdg-mime default shotwell.desktop image/gif
xdg-mime default qutebrowser.desktop x-scheme-handler/http
xdg-mime default qutebrowser.desktop x-scheme-handler/https
    '';

  environment.variables = rec {
      EDITOR  = "nvim";
      BROWSER = "qutebrowser";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  programs = {
    bash.enableCompletion = true;
    ssh.startAgent = true;
    steam.enable = true;
  };

  environment.systemPackages =
  let
    pythonpack = li: ps: with ps; [ numpy scipy ipython virtualenv ansicolor ipdb unittest2 pyflakes yamllint pytest grpcio grpcio-tools protobuf googleapis_common_protos ] ++ li;
    python3pack =  pythonpack [];
  in
  with pkgs; 
    [
    (python3.withPackages( python3pack ))
    aalib
    acpitool
    ant
    arandr
    aspell
    aspellDicts.en
    aspellDicts.nb
    aspellDicts.nn
    astyle
    automake
    baobab # disk usage utility
    bash
    bazel
    bc
    bind
    binutils-unwrapped
    boost
    checkstyle
    clang
    cmake
    cowsay
    cryptsetup
    ctags
    dmenu
    nodejs
    yarn
    dos2unix
    dotnetPackages.Nuget
    dpkg
    dzen2
    enlightenment.terminology
    evince
    fd
    feh
    file
    findbugs
    fira-code
    firefox
    fish
    flyway
    fortune
    fzf
    gcc
    gcolor2
    gdb
    gdk_pixbuf
    ghc
    git
    gitAndTools.tig
    glibcInfo
    gnome3.cheese
    gnumake
    gnupg
    gnupg1orig
    gnuplot
    go
    gparted
    gradle
    graphicsmagick
    graphviz
    haskellPackages.cabal-install
    haskellPackages.hoogle
    haskellPackages.stylish-haskell
    haskellPackages.xmobar
    hdparm
    hicolor_icon_theme
    htop
    iftop
    ii
    imagemagick
    inotify-tools
    iotop
    irssi
    jq
    libfaketime
    libtool
    links2
    llvmPackages.lldb
    lsof
    lua
    man-pages
    manpages
    maven
    mc
    mplayer
    mpv
    msmtp
    nailgun
    ncdu
    ncurses
    neomutt
    networkmanagerapplet
    niv
    nmap
    nodejs
    notmuch
    nox
    ntfs3g
    openjdk
    openssl
    p7zip
    parted
    patchelf
    pavucontrol
    pciutils
    pdftk
    perlPackages.ImageExifTool
    pinentry
    pkgconfig
    posix_man_pages
    postgresql
    protobuf
    pssh
    pwgen
    pythonPackages.autopep8  
    python3Packages.pylint 
    qalculate-gtk
    qemu
    qutebrowser
    rdesktop
    redo
    ripmime
    rlwrap
    rrsync
    rsync
    ruby
    screen                                                                     
    service-wrapper                                                            
    shellcheck                                                                 
    shotwell                                                                   
    shutter                                                                    
    silver-searcher                                                            
    simplescreenrecorder                                                       
    sl
    sloccount
    slock
    sqlite
    sshfs-fuse
    sshuttle
    ack
    stdmanpages
    stepmania
    stress
    stress-ng
    sxiv
    sysstat
    tcptrack
    telnet
    timidity
    toilet
    travis
    tree
    unetbootin
    unzip
    urlview
    usbutils
    valgrind
    vim-vint
    vlc
    wget
    wine
    wipe
    wireshark
    workrave
    xclip
    xdotool
    xfontsel
    xkblayout-state
    xlsfonts
    xorg.xbacklight
    xorg.xev
    xorg.xgamma
    xorg.xkill
    xorg.xmessage
    xorg.xmodmap
    xorg.xorgserver
    xournal
    xscreensaver
    xurls
    xxd
    youtubeDL
    yubikey-manager-qt
    yubikey-personalization
    zeal
    zip
    zlib
    zstd


    (texlive.combine {
        inherit (texlive)
          scheme-full
          # can specify extra packages here
    ;})

  ];


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

  virtualisation.virtualbox.host.enable = false;
  virtualisation.docker.enable = true;

  users.extraUsers.andsild =
  {
    isNormalUser = true;
    home = homedir;
    description = "Anders Sildnes";
    extraGroups = [ "netdev" "wheel" "networkmanager" "vboxusers" "audio" "docker" "wireshark" ];
  };

  sound.mediaKeys = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
