with import <nixpkgs> {}; {
  sdlEnv = stdenv.mkDerivation {
    name = "sdl";
    buildInputs = [ ncurses ];
    shellHook = ''
    source ~/.bashrc
    ''; 
  };
}
