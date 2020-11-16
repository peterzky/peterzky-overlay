self: super:

{
  # fcitx for home-manager
  hm-fcitx-rime =
    super.fcitx.override { plugins = [ super.fcitx-engines.rime ]; };

  # gtk immodule cache
  hm-gtk2-cache = super.runCommand "gtk2-immodule.cache" {
    preferLocalBuild = true;
    allowSubstitutes = false;
    buildInputs = [ super.gtk2 self.hm-fcitx-rime ];
  } ''
    mkdir -p $out/etc/gtk-2.0/
    GTK_PATH=${self.hm-fcitx-rime}/lib/gtk-2.0/ gtk-query-immodules-2.0 > $out/etc/gtk-2.0/immodules.cache
  '';

  hm-gtk3-cache = super.runCommand "gtk2-immodule.cache" {
    preferLocalBuild = true;
    allowSubstitutes = false;
    buildInputs = [ super.gtk3 self.hm-fcitx-rime ];
  } ''
    mkdir -p $out/etc/gtk-3.0/
    GTK_PATH=${self.hm-fcitx-rime}/lib/gtk-3.0/ gtk-query-immodules-3.0 > $out/etc/gtk-3.0/immodules.cache
  '';
}
