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
