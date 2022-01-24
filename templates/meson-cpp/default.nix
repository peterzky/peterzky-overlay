{ stdenv, meson, ninja, pkg-config, sqlite }:
stdenv.mkDerivation rec {
  pname = "example_cpp_meson";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    sqlite
  ];

}
