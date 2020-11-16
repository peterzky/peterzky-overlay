{ stdenv, fetchurl, extra-cmake-modules, fetchFromGitHub, pkgconfig, systemd
, cairo, enchant2, pango, wayland, wayland-protocols, libuuid, isocodes, xorg
, libxkbcommon, xkeyboardconfig, gdk-pixbuf, xcb-imdkit, json_c, pcre
, cldr-emoji-annotation, symlinkJoin, fmt-combined }:

let
  dicts = let SPELL_EN_DICT_VER = "20121020";
  in fetchurl {
    url =
      "http://download.fcitx-im.org/data/en_dict-${SPELL_EN_DICT_VER}.tar.gz";
    sha256 = "1svcb97sq7nrywp5f2ws57cqvlic8j6p811d9ngflplj8xw5sjn4";
  };

in stdenv.mkDerivation rec {
  name = "fcitx5";
  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "fcitx5";
    rev = "aa193780256e2491ff7aebc809c4bfa3c3b7c256";
    # date = 2020-06-23T20:55:07-07:00;
    sha256 = "0g0h0igyjk0wik3j8yz57gfw2lkx5cim00kqkjb9h0wpzjr69f9b";
  };

  prePatch = ''
    cp ${dicts} src/modules/spell/dict/$(stripHash ${dicts})
  '';

  nativeBuildInputs = [ extra-cmake-modules pkgconfig ];

  buildInputs = [
    fmt-combined
    systemd
    pcre
    xcb-imdkit
    cldr-emoji-annotation
    xkeyboardconfig
    json_c
    gdk-pixbuf
    cairo
    enchant2
    pango
    wayland
    wayland-protocols
    libuuid
    isocodes
    libxkbcommon
  ] ++ (with xorg; [ xcbutilwm libxkbfile xcbutilkeysyms ]);

}
