{ stdenv, fetchgit, python3Packages, file, less, sudo, highlight, atool
, mediainfo, ffmpegthumbnailer, ueberzug }:

python3Packages.buildPythonApplication rec {
  name = "ranger";
  version = "git";

  src = fetchgit {
    url = "https://github.com/ranger/ranger.git";
    rev = "ee344c896e85f92f91d097a95e88ae4ead786c7b";
    sha256 = "1j621vsjg8s221raf8v2x3db35zqlfwksqlv6wgq2krpmi729p35";
    # date = 2019-08-18T15:24:03+02:00;
  };

  checkInputs = with python3Packages; [ pytest ];
  propagatedBuildInputs = [
    file
    python3Packages.chardet
    sudo
    highlight
    mediainfo
    atool
    python3Packages.pdf2image
    ffmpegthumbnailer
    ueberzug
  ];

  checkPhase = ''
    py.test tests
  '';

  preConfigure = ''
    substituteInPlace ranger/__init__.py \
    --replace "DEFAULT_PAGER = 'less'" "DEFAULT_PAGER = '${
      stdenv.lib.getBin less
    }/bin/less'"
    for i in ranger/config/rc.conf doc/config/rc.conf ; do
    substituteInPlace $i --replace /usr/share $out/share
    done
  '';

  meta = {
    description = "File manager with minimalistic curses interface";
    homepage = "http://ranger.nongnu.org/";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
  };

}
