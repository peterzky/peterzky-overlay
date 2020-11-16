{ stdenv, fetchzip }:

fetchzip rec {
  name = "SanFranciscoFont";
  sha256 = "0by5z3f1c5nvmcz9nkwd2r8iiirb1biq5v6d6mzylb4ak2mb79f9";
  url =
    "https://github.com/supermarin/YosemiteSanFranciscoFont/archive/master.zip";
  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile \*.ttf -d $out/share/fonts/YSFF
  '';

}
