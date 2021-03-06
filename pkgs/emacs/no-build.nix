{ stdenv
, pkgs
, emacs
, name
, src
, buildInputs ? []
, patches ? []
, preBuild ? ""
}:
stdenv.mkDerivation {
  inherit name src patches;
  unpackCmd = ''
    test -f "${src}" && mkdir el && cp -p ${src} el/${name}
  '';
  buildInputs = [ emacs ] ++ buildInputs;
  buildPhase = ''
    ${preBuild}
    mkdir $out
  '';
  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp/${name}
    install *.el $out/share/emacs/site-lisp/${name}/
  '';
  meta = {
    description = "Emacs projects from the Internet that just compile .el files";
    homepage = http://www.emacswiki.org;
    platforms = pkgs.lib.platforms.all;
  };
}
