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
    rev = "2c644b2ac116e621e72ffd43d4004bc1c3e22973";
    sha256 = "1wzak7y4hf3da8j5cps0jch9zm66lihl37rpnwj7xfbvzsma9qs5";
    # date = 2021-10-06T08:22:11-05:00;
  };

  cargoHash = "sha256-j4seuMO1N1NuwjQJr9nfMMLwSJ/cWGTuY9ph/3/PUDw=";

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
