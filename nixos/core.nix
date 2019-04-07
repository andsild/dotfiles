{ config, lib, pkgs, ... }:

let
  phpSockName1 = "/run/phpfpm/pool1.sock";
  username = "andsild";
  homedir = "/home/" + username + "/";
  concat = l: r: l + r;
in
{
  imports = [
    ./hardware-configuration.nix ./private.nix ./elk.nix ];
    
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #nix.package =  pkgs.nixUnstable;

  networking = {
    networkmanager.enable = true;
    extraHosts = ''
    # I'm addicted, got to stop going there
    127.0.0.1 www.9gag.com
    127.0.0.1 9gag.com
    127.0.0.1 www.imgur.com
    127.0.0.1 imgur.com

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
    virtualbox.enableExtenstionPack = false;
    # zathura.useMupdf = true;
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.tcp.enable = true;
  hardware.pulseaudio.tcp.anonymousClients.allowedIpRanges = [ "127.0.0.1" ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.extraConfig = ''
    Name=%h-nix
    AutoConnectTimeout = 30
    FastConnectable = true
    NameResolving = false
    '';
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

  environment.shellInit = ''
    # gpg-connect-agent /bye
    # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  environment.variables = rec {
    EDITOR  = "nvim";
    BROWSER = "qutebrowser";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };

  environment.systemPackages =
  let
    nvim = pkgs.neovim.override {
      vimAlias = true;
      withPyGUI = false;
    };
    pythonpack = li: ps: with ps; [ numpy scipy neovim ipython virtualenv ansicolor jedi ipdb unittest2 pyflakes yamllint pytest grpcio grpcio-tools protobuf googleapis_common_protos ] ++ li;
    python2pack = pythonpack [];
    python3pack =  pythonpack [];
  in
  with pkgs; 
    [
    (eclipses.eclipseWithPlugins {
          eclipse = eclipses.eclipse-platform-49;
          jvmArgs = [ "-Xmx2048m" "-Xms1024m" ];
          plugins = with eclipses.plugins; [ checkstyle color-theme findbugs jdt spotbugs testng vrapper ];
    })
    (python2.withPackages( python2pack ))
    (python3.withPackages( python3pack ))
    aalib
    acpitool
    androidsdk
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
    blueman
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
    mono46
    mplayer
    mpv
    msmtp
    nailgun
    ncdu
    ncurses
    neomutt
    networkmanagerapplet
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
    stack
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
    xpdf
    xscreensaver
    xurls
    xxd
    youtubeDL
    yubikey-neo-manager
    yubikey-personalization
    # zathura
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
          # collection-genericextra
          # collection-genericrecommended
          # collection-htmlxml
          collection-humanities
          # collection-langafrican
          # collection-langarabic
          # collection-langchinese
          collection-langcjk
          collection-langcyrillic
          collection-langczechslovak
          collection-langenglish
          collection-langeuropean
          collection-langfrench
          collection-langgerman
          # collection-langindic
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
          # collection-mathextra
          collection-metapost
          collection-music
          # collection-omega
          collection-pictures
          # collection-plainextra
          collection-pstricks
          collection-publishers
          # collection-science
          collection-texworks
          collection-wintools
          collection-xetex

          metafont;
    })

  ];

  services = {
    prometheus = {
      enable = false;
      listenAddress = "0.0.0.0:9090";
      ruleFiles = [ "/home/andsild/work/prometheus-config/rules.d/" ] ;
    };

    consul = {
      enable = true;
      webUi = true;
    };



    resolved.enable = true;
    resolved.domains = ["cxense.com"];
    acpid.enable = true;
    pcscd.enable = true;
    clamav.daemon.enable = true;
    clamav.updater.enable = true;
    clamav.updater.frequency = 1;

    offlineimap.enable = true; # so much hassling with the setup, not sure if CLI email is worth it yet
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

    udev.packages = with pkgs; [ yubikey-personalization ];
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

    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = true;
      challengeResponseAuthentication = true;
      knownHosts = [
        { 
          hostNames = ["self"];
          publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDntHshA0NiBwAT1v+aCsOuwKp7qQeyKhy3rWGlYN9rDxbqayIsYtg1zLYRExBpstCni9GUyPwyQXX69qOkVdpXNH9XyIz/LD4xL/Fp8niNUuAU0xaHO2nNC6oOE4tN1oN2ic5EC6ZPpdUvD1KnQl6FFsBWaM9UrBemX7u+ATt2faVUE0tFEzkNScggP2MUxJMPxagnAr2Ro1tetpSxmx61Nd7IBMHI4j4eoSHj6Hav4DbGDgMaK6IMfAyoPMwC7eqYCFx+1vXm55EQna3mIHC9+tnxwvXoFlOxvtPEj0A78h3OMA/gICmPDZtF+i9Al46sTJ7f5sebilx6cJQJYW8J1fOV+dGcy8P2baVXuxRdNSj97B+iX6/RXZtwB/WcBKnhAv5r+yMgVapXs7pb3sh1Q5js5RV4LwBp1sd7o1NPTJE9WKTeWdUt/ggvZ4gZFNtasTevWe1F8sw5y6wYM1mQq0HrtfESG61TDtT6Lc2HWJnX3i6B6rcwynVbJlC5dOP0onfxeViS0J/U6vEk7f2vHhSZxS+EFXyVoVhx3DW2XNmGsQ2tApBBB7Ek+naN4oWvPlMwAo8cZFZrZc+pneZYELLmhKuf6dKZC7q+iLfbGmi1ZPn9r6u3UKUZ/9aw8LiRNB/NIKhlTBqxGq421DWI/aZD2Mw+wiH7oDBaYP6zdQ== andsild@posteo.net";
        }
      ];
    };
    locate.enable = true;
    locate.interval = "*:0/30";
    locate.localuser = username;
    locate.prunePaths = ["/tmp" "/var/tmp" "/proc" "/var/cache" "/var/lock" "/var/run" "/var/spool" "/mnt" "/opt" "/boot" "/var/lib/docker" "/lost+found" "/var/lib/containers" "/root" "/var/db/sudo" "/var/lib/postgresql" "/var/lib/bluetooth" "/etc/docker" "/etc/NetworkManager" "/nix/var" ] ++ map (concat homedir) ["Downloads" ".cache" ".thunderbird" ".gitfat" ".stack" "work/cx" ".gem" ".local/share" ];

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
      enable = false;
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
      enable = false;
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

    postgresql = {
      enable = true;
      authentication = lib.mkForce ''
# Generated file from configuration.nix; do not edit!
local all all              trust
host  all all 127.0.0.1/32 trust
host  all all ::1/128      trust
      '';
    extraConfig = ''
log_connections = no
logging_collector = false
track_activities = false
track_counts = false
update_process_title = false
      '';
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
  system.stateVersion = "18.09";
}
