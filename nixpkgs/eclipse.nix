self: super:

{
  eclipse-platform = super.eclipses.eclipseWithPlugins {
    eclipse = super.eclipses.eclipse-platform;
    jvmArgs = [ "-Xmx2048m" "-Xms2048m" ];
    plugins = with super.eclipses.plugins; [ checkstyle color-theme findbugs jdt vrapper testng ];
  };
}
