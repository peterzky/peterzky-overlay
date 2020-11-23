{ stdenv, fetchFromGitHub, libusb1, ncsdk-fw, pythonPackages }:
let
  python-site =
    "$out/lib/${pythonPackages.python.libPrefix}/site-packages/mvnc";

in stdenv.mkDerivation rec {
  name = "ncsdk";
  version = "git";

  src = fetchFromGitHub {
    owner = "movidius";
    repo = "ncsdk";
    rev = "v2.08.01.02";
    sha256 = "0ab925nar992acs7751j07pbqww5bn6349klqgxv07zskvv1ji4d";

  };

  buildInputs = [ libusb1 ];

  propagatedBuildInputs = [ pythonPackages.numpy ];

  passthru = { pythonPath = [ ]; };

  sourceRoot = "source/api/src";

  patchPhase = ''
    substituteInPlace Makefile \
      --replace "-I\$(SYSROOT)/usr/include/libusb-1.0 \\" \
                "-I${libusb1.dev}/include/libusb-1.0" \
      --replace "@./get_mvcmd.sh" ""
  '';

  buildPhase = ''
    make all
  '';

  installPhase = ''
    mkdir -p $out/lib/mvnc
    mkdir -p $out/include
    mkdir -p ${python-site}
    cp libmvnc.so.0 $out/lib
    cp libmvnc.so $out/lib
    cp ../include/*.h $out/include
    cp ${ncsdk-fw}/*.mvcmd $out/lib/mvnc/
    cp -r ../python/mvnc/*.py ${python-site}
  '';

  postFixup = ''
    substituteInPlace ${python-site}/mvncapi.py \
      --replace "./libmvnc.so" "$out/lib/libmvnc.so"
  '';

}
