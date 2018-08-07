{
  allowUnfree = false;
  packageOverrides = pkgs: rec {
    eclipses = pkgs.eclipses.override {
      jdk = jdk8
    };
  };
}
