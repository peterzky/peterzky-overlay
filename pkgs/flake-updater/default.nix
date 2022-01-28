{ stdenv, lib, fetchFromGitHub, meson, ninja, pkg-config, json_c }:
stdenv.mkDerivation rec {
  pname = "flake-updater";
  version = "0.0.1";

  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    json_c
  ];

}
