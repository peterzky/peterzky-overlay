{ lib, fetchFromGitHub, rustPlatform, libX11, libXinerama }:

let
  rpathLibs = [ libXinerama libX11 ];
in

rustPlatform.buildRustPackage rec {
  pname = "leftwm";
  version = builtins.substring 0 6 src.rev;

  src = fetchFromGitHub {
    owner = "leftwm";
    repo = "leftwm";
    rev = "6f130f42c61e0a89ab7942f4d3ff3f69b46e8f2d";
    sha256 = "0171ynw266iwgz1hcjy4bj8v2r2h5sl1f9ycdrk3s7p6pp93a0gp";
    # date = 2021-10-04T08:19:58-05:00;
  };

  cargoHash = "sha256-WlT5guiMa1zk/FNjI3hAMPl8wwjxajXlr1VU6q/r51E=";

  buildInputs = rpathLibs;

  postInstall = ''
    for p in $out/bin/leftwm*; do
      patchelf --set-rpath "${lib.makeLibraryPath rpathLibs}" $p
    done
  '';

  dontPatchELF = true;

  meta = with lib; {
    description = "A tiling window manager for the adventurer";
    homepage = "https://github.com/leftwm/leftwm";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ mschneider ];
    changelog = "https://github.com/leftwm/leftwm/blob/${src.rev}/CHANGELOG";
  };
}
