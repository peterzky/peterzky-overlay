final: prev:
{
  # sws = prev.callPackage ../pkgs/shell-script/sws { };

  # lf-pv = prev.callPackage ../pkgs/shell-script/lf-pv.nix {};

  # lsix = prev.callPackage ../pkgs/shell-script/lsix.nix {};

  audio-switch-menu = prev.callPackage ../pkgs/shell-script/audio-switch-menu.nix { };

  screen-dict = prev.callPackage ../pkgs/shell-script/screen-dict.nix { };

  volume-ctl = prev.callPackage ../pkgs/shell-script/volume-ctl.nix { };

  tts = prev.writeScriptBin "tts" ''
    ${prev.python3Packages.gtts}/bin/gtts-cli "$(${prev.wl-clipboard}/bin/wl-paste -p -n)" | mpv --speed=1.2 -
  '';

  sway-lid-state = prev.writeScript "sway-lib-state" ''
    if grep -q open /proc/acpi/button/lid/LID/state; then
      swaymsg output eDP-1 enable
    else
      swaymsg output eDP-1 disable
    fi
  '';
  sway-import-gsettings = prev.writeScript "import-gsettings" ''
    config="$XDG_CONFIG_HOME/gtk-3.0/settings.ini"
    if [ ! -f "$config" ]; then exit 1; fi

    gnome_schema="org.gnome.desktop.interface"
    gtk_theme="$(grep 'gtk-theme-name' "$config" | cut -d'=' -f2)"
    icon_theme="$(grep 'gtk-icon-theme-name' "$config" | cut -d'=' -f2)"
    cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | cut -d'=' -f2)"
    font_name="$(grep 'gtk-font-name' "$config" | cut -d'=' -f2)"
    ${prev.glib}/bin/gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
    ${prev.glib}/bin/gsettings set "$gnome_schema" icon-theme "$icon_theme"
    ${prev.glib}/bin/gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
    ${prev.glib}/bin/gsettings set "$gnome_schema" font-name "$font_name"
  '';

}
