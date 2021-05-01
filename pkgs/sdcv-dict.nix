{ stdenv, fetchzip }:

fetchzip rec {
  name = "langdao-ec-gb";
  url =
    "https://github.com/peterzky/nixos-electron-cache/raw/master/ld-dict.tar.bz2";
  sha256 = "1v7xagkcrpkb328816nlar6saymr6x8xw5hmfmgph66k8wkfm0hj";
  postFetch = ''
    mkdir -p $out/share/ld-dict
    tar xjf $downloadedFile -C $out/share
    mv $out/share/stardict-langdao-ec-gb-2.4.2/* $out/share/ld-dict
    rmdir $out/share/stardict-langdao-ec-gb-2.4.2
  '';
}
