{
  allowUnfree = false;
  packageOverrides = pkgs: rec {
    myEclipse = with pkgs.eclipses; eclipseWithPlugins {
      eclipse = eclipse-platform;
      jvmArgs = [ "-Xmx2048m" "-Xms2048m" ];
      plugins = with plugins; [ checkstyle color-theme findbugs jdt vrapper testng ];
    };
  };
}
