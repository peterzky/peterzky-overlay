{ stdenv, lib, unzip }:

stdenv.mkDerivation rec {
  name = "input-fonts-${version}";
  version = "2017-08-10"; # date of the download and checksum

  src = ./Input-Font.zip;

  nativeBuildInputs = [ unzip ];

  phases = [ "unpackPhase" "installPhase" ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    find Input_Fonts -name "*.ttf" -exec cp -a {} "$out"/share/fonts/truetype/ \;
    mkdir -p "$out"/share/doc
    cp -a *.txt "$out"/share/doc/
  '';

  meta = with lib; {
    description = "Fonts for Code, from Font Bureau";
    longDescription = ''
      Input is a font family designed for computer programming, data,
      and text composition. It was designed by David Jonathan Ross
      between 2012 and 2014 and published by The Font Bureau. It
      contains a wide array of styles so you can fine-tune the
      typography that works best in your editing environment.

      Input Mono is a monospaced typeface, where all characters occupy
      a fixed width. Input Sans and Serif are proportional typefaces
      that are designed with all of the features of a good monospace —
      generous spacing, large punctuation, and easily distinguishable
      characters — but without the limitations of a fixed width.
    '';
    homepage = "http://input.fontbureau.com";
    platforms = platforms.all;
  };
}
