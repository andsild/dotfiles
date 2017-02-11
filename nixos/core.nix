{ config, lib, pkgs, ... }:

let
  phpSockName1 = "/run/phpfpm/pool1.sock";
in
{
  imports = [
    ./hardware-configuration.nix ./private.nix];


  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    networkmanager.enable = true;
    extraHosts = ''
    # I'm addicted, got to stop going there
    127.0.0.1 www.9gag.com
    127.0.0.1 9gag.com
    127.0.0.1 www.imgur.com
    127.0.0.1 imgur.com


   192.168.1.168 phone
    '';

    wireless.userControlled.enable = true;
    firewall = {
      enable = true;
      allowPing = false;

      connectionTrackingModules = [];
      autoLoadConntrackHelpers = false;
    };
  };

  security.sudo.enable = true;
  security.polkit.enable = true;
  security.setuidOwners = [
      (lib.mkIf (builtins.elem pkgs.wireshark config.environment.systemPackages) {
      # Limit access to dumpcap to root and members of the wireshark group.
      source = "${pkgs.wireshark}/bin/dumpcap";
      program = "dumpcap";
      owner = "root";
      group = "wireshark";
      setuid = true;
      setgid = false;
      permissions = "u+rx,g+x";
      })
      (lib.mkIf (builtins.elem pkgs.smartmontools config.environment.systemPackages) {
      # Limit access to smartctl to root and members of the munin group.
      source = "${pkgs.smartmontools}/bin/smartctl";
      program = "smartctl";
      owner = "root";
      group = "munin";
      setuid = true;
      setgid = false;
      permissions = "u+rx,g+x";
      })
  ];

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
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.tcp.enable = true;
  hardware.pulseaudio.tcp.anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
  hardware.bluetooth.enable = true;
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };

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
    acpitool
    aalib
    aspell
    bind
    iotop
    aspellDicts.en
    aspellDicts.nb
    aspellDicts.nn
    astyle
    androidsdk
    automake
    bash
    bc
    boost
    chromium
    clang
    cmake
    cowsay
    lsof
    ctags
    dmenu
    dpkg
    openjdk
    dzen2
    enlightenment.terminology
    file
    fortune
    fzf
    gcc
    gcolor2
    gdb
    gdk_pixbuf
    git
    glibcInfo
    gnome3.cheese
    gnumake
    gnupg
    gnupg1orig
    go
    gparted
    graphicsmagick
    graphviz
    haskellPackages.cabal-install
    #haskellPackages.hindent # would be nice, but the version is outdated (use cabal for now)
    haskellPackages.stylish-haskell
    haskellPackages.threadscope
    travis
    haskellPackages.cabal2nix
    haskellPackages.ghc
    haskellPackages.ghc-mod
    haskellPackages.happy
    haskellPackages.hlint
    haskellPackages.hoogle
    pinentry
    hicolor_icon_theme
    htop
    stress-ng
    imagemagick
    inotify-tools
    irssi
    libtool
    liblapack
    links2
    gitAndTools.tig
    llvmPackages.lldb
    lua
    ii
    nmap
    unetbootin
    man-pages
    manpages
    mplayer
    msmtp
    ncurses
    neomutt
    networkmanagerapplet
    newsbeuter-dev
    nodejs
    notmuch
    nox
    ntfs3g
    nvim
    openssl
    p7zip
    parted
    pavucontrol
    pdftk
    pinentry
    pkgconfig
    posix_man_pages
    python
    python3
    python3Packages.ipython
    python3Packages.neovim
    python3Packages.scipy
    python3Packages.virtualenv
    python3Packages.yamllint
    pythonPackages.goobook
    pythonPackages.youtube-dl
    pythonPackages.ipython
    pythonPackages.neovim
    pythonPackages.scipy
    pythonPackages.virtualenv
    qalculate-gtk
    qemu
    rdesktop
    rsync
    ruby
    screen
    shellcheck
    shotwell
    silver-searcher
    simplescreenrecorder
    sl
    sloccount
    slock
    slop
    sqlite
    sshfs-fuse
    stack
    shutter
    stdmanpages
    sxiv
    telnet
    toilet
    tree
    unzip
    unzip
    valgrind
    vlc
    wget
    workrave
    xclip
    xdotool
    xfontsel
    xkblayout-state
    xlsfonts
    xorg.xbacklight
    xorg.xkill
    xorg.xev
    xorg.xgamma
    xorg.xmessage
    xorg.xorgserver
    xournal
    xpdf
    xscreensaver
    zathura
    zeal
    zip
    zlib
    stepmania
    usbutils
    wine
    dos2unix
    perlPackages.ImageExifTool
    wireshark

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
    clamav.daemon.enable = true;
    clamav.updater.enable = true;
    clamav.updater.frequency = 1;

    munin-node = {
      enable = true;
      extraConfig = ''
        cidr_allow 192.168.56.0/24
    '';
    };
    munin-cron = {
      enable = true;
      hosts = ''
        [${config.networking.hostName}]
        address localhost
      '';
    };

    udev.extraRules = ''
# Leap Motion
ACTION!="add|change", GOTO="com_leapmotion_leap_end"
SUBSYSTEM=="usb", ATTRS{idVendor}=="f182", ATTRS{idProduct}=="0003", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="00f3", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="04b4", ATTRS{idProduct}=="4720", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1001", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1002", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1003", MODE="666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTRS{idVendor}=="2936", ATTRS{idProduct}=="1004", MODE="666", GROUP="plugdev"
LABEL="com_leapmotion_leap_end"
 '';

    openssh.enable = true;
    openssh.extraConfig = ''Ciphers arcfour,3des-cbc,blowfish-cbc,cast128-cbc,arcfour,arcfour128,arcfour256,aes128-cbc,aes192-cbc,aes256-cbc,rijndael-cbc@lysator.liu.se,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com,chacha20-poly1305@openssh.com
'';
    locate.enable = true;
    locate.interval = "*:0/30";
    locate.localuser = "nobody";
    locate.prunePaths = ["/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/mnt" "/opt" ];


    offlineimap.enable = true;
    offlineimap.install = true;
    offlineimap.path = [ pkgs.gnupg1orig pkgs.python pkgs.gnupg pkgs.python pkgs.notmuch pkgs.bash pkgs.sqlite pkgs.pinentry  ];
    offlineimap.onCalendar = "*:0/3"; # every three minutes

    printing.enable = true;

    xserver = {
      enable = true;
      layout = "us,no";
      xkbOptions = "eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no";
     #exportConfiguration = true;
      windowManager.wmii.enable = true;
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      displayManager = {
        sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
        slim = {
          enable = true;
          defaultUser = "andesil";
          theme = pkgs.fetchurl {
              url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
              sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
          };
        };
      };
    };

    # thanks bjornfor (https://github.com/bjornfor/nixos-config)
    lighttpd = {
      enable = true;
      #mod_status = true; # don't expose to the public
      mod_userdir = true;
      enableModules = [ "mod_alias" "mod_proxy" "mod_access" "mod_fastcgi" "mod_redirect" ];
      extraConfig =
        let
          collectd-graph-panel =
            pkgs.stdenv.mkDerivation rec {
              name = "collectd-graph-panel-${version}";
              version = "0.4.1";
              src = pkgs.fetchzip {
                name = "${name}-src";
                url = "https://github.com/pommi/CGP/archive/v${version}.tar.gz";
                sha256 = "14jm7jidp4z0vcd9rcblrqkp6mfbmvc548biwrjylm6yvdjgqb9l";
              };
              buildCommand = ''
                mkdir -p "$out"
                cp -r "$src"/. "$out"
                chmod +w "$out"/conf
                cat > "$out"/conf/config.local.php << EOF
                <?php
                \$CONFIG['datadir'] = '/var/lib/collectd';
                \$CONFIG['rrdtool'] = '${pkgs.rrdtool}/bin/rrdtool';
                \$CONFIG['graph_type'] = 'canvas';
                ?>
                EOF
              '';
            };
        in ''
        $HTTP["host"] =~ ".*" {
          dir-listing.activate = "enable"
          alias.url += ( "/munin" => "/var/www/munin" )
          # Reverse proxy for transmission bittorrent client
          proxy.server = (
            "/transmission" => ( "transmission" => (
                                 "host" => "127.0.0.1",
                                 "port" => 9091
                               ) )
          )
          # Fix transmission URL corner case: get error 409 if URL is
          # /transmission/ or /transmission/web. Redirect those URLs to
          # /transmission (no trailing slash).
          url.redirect = ( "^/transmission/(web)?$" => "/transmission" )
          alias.url += ( "/collectd" => "${collectd-graph-panel}" )
          $HTTP["url"] =~ "^/collectd" {
            index-file.names += ( "index.php" )
          }

          fastcgi.server = (
            ".php" => (
              "localhost" => (
                "socket" => "${phpSockName1}",
              )
            )
          )

          # Block access to certain URLs if remote IP is not on LAN
          $HTTP["remoteip"] !~ "^(192\.168\.1|127\.0\.0\.1)" {
              $HTTP["url"] =~ "(^/transmission/.*|^/server-.*|^/munin/.*|^/collectd.*)" {
                  url.access-deny = ( "" )
              }
          }
        }
      '';
    };

    phpfpm.poolConfigs = lib.mkIf config.services.lighttpd.enable {
          pool1 = ''
            listen = ${phpSockName1}
            listen.group = lighttpd
            user = nobody
            pm = dynamic
            pm.max_children = 75
            pm.start_servers = 10
            pm.min_spare_servers = 5
            pm.max_spare_servers = 20
            pm.max_requests = 500
          '';
        };

    # TODO: Change perms on /var/lib/collectd from 700 to something more
    # permissive, at least group readable?
    # The NixOS service currently only sets perms *once*, so I've manually
    # loosened it up for now, to allow lighttpd to read RRD files.
    collectd = {
      enable = true;
      extraConfig = ''
        # Interval at which to query values. Can be overwritten on per plugin
        # with the 'Interval' option.
        # WARNING: You should set this once and then never touch it again. If
        # you do, you will have to delete all your RRD files.
        Interval 10
        # Load plugins
        LoadPlugin apcups
        LoadPlugin contextswitch
        LoadPlugin cpu
        LoadPlugin df
        LoadPlugin disk
        LoadPlugin ethstat
        LoadPlugin interface
        LoadPlugin irq
        LoadPlugin virt
        LoadPlugin load
        LoadPlugin memory
        LoadPlugin network
        LoadPlugin nfs
        LoadPlugin processes
        LoadPlugin rrdtool
        LoadPlugin sensors
        LoadPlugin tcpconns
        LoadPlugin uptime
        <Plugin "virt">
          Connection "qemu:///system"
        </Plugin>
        <Plugin "df">
          MountPoint "/"
          MountPoint "/mnt/data/"
          MountPoint "/mnt/backup-disk/"
        </Plugin>
        # Output/write plugin (need at least one, if metrics are to be persisted)
        <Plugin "rrdtool">
          CacheFlush 120
          WritesPerSecond 50
        </Plugin>
      '';
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
  virtualisation.docker.enable = true;


  users.extraUsers.andesil =
  {
    isNormalUser = true;
    home = "/home/andesil";
    description = "Anders Sildnes";
    extraGroups = [ "netdev" "wheel" "networkmanager" "vboxusers" "audio" "docker" "wireshark" ];
  };
  users.extraGroups.wireshark.gid = 500;


  sound.mediaKeys = {
    enable = true;
    volumeStep = "1000";
  };
  system.stateVersion = "17.03";
}
