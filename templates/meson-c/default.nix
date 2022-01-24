{ stdenv, meson, ninja, pkg-config, libuv, json_c }:
stdenv.mkDerivation rec {
  pname = "meson_c";
  version = "0.0.1";

  src = ./.;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    libuv
    json_c
  ];

}
