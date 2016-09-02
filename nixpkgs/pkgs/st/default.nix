{ stdenv, fetchurl, pkgconfig, writeText, libX11, ncurses, libXext, libXft, fontconfig
, conf ? null, patches ? []}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "st";
  version = "0.7";
  
  src = fetchurl {
    url = "http://dl.suckless.org/st/${name}-${version}.tar.gz";
    sha1 = "358bca5bfc6ee85352dcd4f45f13f78474e5de42";
  };

  inherit patches;

  configFile = optionalString (conf!=null) (writeText "config.def.h" conf);
  preBuild = ''
  ${optionalString (conf!=null) "cp ${configFile} config.def.h"}
  ${optionalString (conf==null) "cat <<EOF > fixdelkey.patch
*** original
--- modified
***************
*** 316,321 ****
     { XK_Delete,        ShiftMask,      \"\\033[2K\",      -1,    0,    0},
     { XK_Delete,        ShiftMask,      \"\\033[3;2~\",    +1,    0,    0},
!    { XK_Delete,        XK_ANY_MOD,     \"\\033[P\",       -1,    0,    0},
!    { XK_Delete,        XK_ANY_MOD,     \"\\033[3~\",      +1,    0,    0},
     { XK_BackSpace,     XK_NO_MOD,      \"\\177\",          0,    0,    0},
     { XK_BackSpace,     Mod1Mask,       \"\\033\\177\",      0,    0,    0},
--- 316,321 ----
     { XK_Delete,        ShiftMask,      \"\\033[2K\",      -1,    0,    0},
     { XK_Delete,        ShiftMask,      \"\\033[3;2~\",    +1,    0,    0},
!    { XK_Delete,        XK_ANY_MOD,     \"\\033[P\",       +1,    0,    0},
!    { XK_Delete,        XK_ANY_MOD,     \"\\033[3~\",      -1,    0,    0},
     { XK_BackSpace,     XK_NO_MOD,      \"\\177\",          0,    0,    0},
     { XK_BackSpace,     Mod1Mask,       \"\\033\\177\",      0,    0,    0},
EOF
cat fixdelkey.patch
#patch -p0 --verbose config.def.h < fixdelkey.patch"}
  '';
  
  buildInputs = [ pkgconfig libX11 ncurses libXext libXft fontconfig ];

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';
    
  meta = {
    homepage = http://st.suckless.org/;
    license = stdenv.lib.licenses.mit;
    maintainers = with maintainers; [viric];
    platforms = platforms.linux;
  };
}
