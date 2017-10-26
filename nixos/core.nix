{ config, lib, pkgs, ... }:

let
  phpSockName1 = "/run/phpfpm/pool1.sock";
  username = "andsild";
in
{
  imports = [
    ./hardware-configuration.nix ./private.nix ./elk.nix ];


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
   129.241.103.34 baby

      10.40.119.152 caligula
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
  security.wrappers = {
    slock = {
      source = "${pkgs.slock.out}/bin/slock";
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };


  time.timeZone = "Europe/Oslo";

  nixpkgs.config = {
    allowUnfree = true;
    # chromium = {
    #   enablePepperFlash = true;
    #   enablePepperPDF = true;
    # };
    # firefox = {
    #   enableGoogleTalkPlugin = true;
    #   enableAdobeFlash = true;
    # };
    virtualbox.enableExtenstionPack = true;
    zathura.useMupdf = true;
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
    enableCoreFonts = false;
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
    BROWSER = "qutebrowser";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };

  environment.systemPackages =
  let
    nvim = pkgs.neovim.override {
      vimAlias = true;
    };
  in
  with pkgs; [
    aalib
    acpitool
    androidsdk
    aspell
    aspellDicts.en
    aspellDicts.nb
    aspellDicts.nn
    astyle
    automake
    bash
    bazel
    bc
    bind
    boost
    checkstyle
    chromium
    clang
    cmake
    cowsay
    ctags
    dmenu
    dos2unix
    dotnetPackages.Nuget
    dpkg
    dzen2
    eclipses.eclipse-platform
    enlightenment.terminology
    evince
    file
    findbugs
    fortune
    fzf
    gcc
    gcolor2
    gdb
    gdk_pixbuf
    git
    gitAndTools.tig
    glibcInfo
    gnome3.cheese
    gnumake
    gnupg
    gnupg1orig
    go
    gparted
    gradle
    graphicsmagick
    graphviz
    # haskellPackages.cabal-install
    # haskellPackages.cabal2nix
    haskellPackages.ghc
    haskellPackages.ihaskell
    # haskellPackages.ghc-mod
    # haskellPackages.happy
    haskellPackages.hindent
    haskellPackages.hoogle
    # haskellPackages.stylish-haskell
    # haskellPackages.threadscope
    # hasklig
    fira-code
    hicolor_icon_theme
    htop
    ii
    jq
    imagemagick
    inotify-tools
    iotop
    irssi
    liblapack
    libtool
    links2
    llvmPackages.lldb
    lsof
    lua
    man-pages
    manpages
    maven
    mplayer
    mpv
    msmtp
    ncdu
    ncurses
    neomutt
    networkmanagerapplet
    nix-repl
    nmap
    nodejs
    notmuch
    nox
    ntfs3g
    nvim
    mc
    mono46
    monodevelop
    openjdk
    openssl
    p7zip
    parted
    pavucontrol
    pdftk
    pciutils
    perlPackages.ImageExifTool
    pinentry
    pkgconfig
    posix_man_pages
    python
    python3Packages.ipython
    python3Packages.python
    python3Packages.neovim
    pythonPackages.ipython
    pythonPackages.scipy
    pythonPackages.virtualenv
    pythonPackages.scipy
    python3Packages.scipy
    pythonPackages.virtualenv
    pythonPackages.youtube-dl
    qalculate-gtk
    qemu
    qutebrowser
    rdesktop
    redo
    rlwrap
    rsync
    rrsync
    ruby
    screen
    shellcheck
    shotwell
    shutter
    silver-searcher
    simplescreenrecorder
    sl
    sloccount
    slock
    slop
    sqlite
    sshfs-fuse
    stack
    stdmanpages
    stepmania
    stress-ng
    sxiv
    sysstat
    tcptrack
    telnet
    thunderbird
    toilet
    travis
    tree
    unetbootin
    unzip
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
    xorg.xorgserver
    xournal
    xpdf
    xscreensaver
    xxd
    zathura
    zeal
    zip
    zlib
    zstd

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

    offlineimap.enable = true;
    offlineimap.install = true;
    offlineimap.path = [ pkgs.gnupg1orig pkgs.python pkgs.gnupg pkgs.python pkgs.notmuch pkgs.bash pkgs.sqlite pkgs.pinentry  ];
    offlineimap.onCalendar = "*:0/4"; # every three minutes

    elk = {
      enable = false;
      systemdUnits = [ "kibana" ];
    };

    munin-node = {
      enable = false; # fastcgi not supported?
      extraConfig = ''
        cidr_allow 192.168.1.0/24
        html_strategy cgi
        graph_strategy cgi
    '';
    };
    munin-cron = {
      enable = false; # fastcgi not supported?
      hosts = ''
        [laptop]
        address 192.168.1.207

        [bigmoma]
        address 192.168.1.139
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

# dinivo edge
#KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \ RUN+="hid2hci --method=logitech-hid --devpath=%p";
#'';

    openssh.enable = true;
    openssh.extraConfig = ''Ciphers arcfour,3des-cbc,blowfish-cbc,cast128-cbc,arcfour,arcfour128,arcfour256,aes128-cbc,aes192-cbc,aes256-cbc,rijndael-cbc@lysator.liu.se,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com,chacha20-poly1305@openssh.com
'';
    openssh.permitRootLogin = "no";
    openssh.passwordAuthentication = false;
    openssh.challengeResponseAuthentication = false;
    locate.enable = true;
    locate.interval = "*:0/30";
    locate.localuser = "nobody";
    locate.prunePaths = ["/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/mnt" "/opt" ];

    xserver = {
      enable = true;
      # setxkbmap  -option eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no
      layout = "us,no";
      xkbOptions = "eurosign:e,grp:switch,grp:alt_shift_toggle,grp_led:scroll us,no";
      windowManager.wmii.enable = true;
      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      displayManager = {
        sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
        slim = {
          enable = true;
          defaultUser = username;
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
              $HTTP["url"] =~ "(^/munin/.*|^/collectd.*)" {
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
        LoadPlugin contextswitch
        LoadPlugin cpu
        LoadPlugin df
        LoadPlugin disk
        LoadPlugin ethstat
        LoadPlugin interface
        LoadPlugin irq
        LoadPlugin load
        LoadPlugin memory
        LoadPlugin network
        LoadPlugin nfs
        LoadPlugin processes
        LoadPlugin rrdtool
        LoadPlugin sensors
        LoadPlugin tcpconns
        LoadPlugin uptime
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

  environment.extraInit = ''
    xdg-mime default zathura.desktop application/pdf
    xdg-mime default qutebrowser.desktop text/html
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

  users.extraUsers.andsild =
  {
    isNormalUser = true;
    home = "/home/" + username;
    description = "Anders Sildnes";
    extraGroups = [ "netdev" "wheel" "networkmanager" "vboxusers" "audio" "docker" "wireshark" ];
  };

  sound.mediaKeys = {
    enable = true;
  };
  system.stateVersion = "18.03";
}
