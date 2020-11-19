{ stdenv, lib, fetchFromGitHub, python3Packages, file, less, highlight
, imagePreviewSupport ? true, w3m ? null }:

with stdenv.lib;

assert imagePreviewSupport -> w3m != null;

python3Packages.buildPythonApplication rec {
  name = "ranger-${version}";
  version = "git";

  src = fetchFromGitHub {
    owner = "3ap";
    repo = "ranger";
    rev = "240d8a0ea1b82690372ba067c24a3f581a29c782";
    # date = 2020-08-01T12:19:50+02:00;
    sha256 = "1pd9mw2yac2ndcngh41nkg0p7x9kly9q8ia6mymagvpwafjfcimn";
  };

  LC_ALL = "en_US.UTF-8";

  checkInputs = with python3Packages; [ pytest ];
  propagatedBuildInputs = [ file ]
    ++ lib.optionals (imagePreviewSupport) [ python3Packages.pillow ];

  checkPhase = "\n";

  preConfigure = ''
    ${lib.optionalString (highlight != null) ''
      sed -i -e 's|^\s*highlight\b|${highlight}/bin/highlight|' \
        ranger/data/scope.sh
    ''}

    substituteInPlace ranger/data/scope.sh \
      --replace "/bin/echo" "echo"

    substituteInPlace ranger/__init__.py \
      --replace "DEFAULT_PAGER = 'less'" "DEFAULT_PAGER = '${
        stdenv.lib.getBin less
      }/bin/less'"

    for i in ranger/config/rc.conf doc/config/rc.conf ; do
      substituteInPlace $i --replace /usr/share $out/share
    done

    # give file previews out of the box
    substituteInPlace ranger/config/rc.conf \
      --replace "#set preview_script ~/.config/ranger/scope.sh" "set preview_script $out/share/doc/ranger/config/scope.sh"
  '' + optionalString imagePreviewSupport ''
    substituteInPlace ranger/ext/img_display.py \
      --replace /usr/lib/w3m ${w3m}/libexec/w3m

    # give image previews out of the box when building with w3m
    substituteInPlace ranger/config/rc.conf \
      --replace "set preview_images false" "set preview_images true"
  '';

  meta = with lib; {
    description = "File manager with minimalistic curses interface";
    homepage = "http://ranger.github.io/";
    license = licenses.gpl3;
    platforms = platforms.unix;
    maintainers = [ maintainers.toonn maintainers.magnetophon ];
  };
}
