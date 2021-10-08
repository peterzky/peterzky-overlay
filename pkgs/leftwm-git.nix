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
    rev = "b4a06860ee5715ce89bc882012e2406a70c7795b";
    sha256 = "0hv1yw4csnbsbq10fs9v04vfka2j8dh3yjg93sj7gwxxciryfgby";
    # date = 2021-10-07T08:14:10-05:00;
  };

  cargoHash = "sha256-gFiKtIDIyvMWK0GuFd6guvGa+a23zcqafEuzdljqk+k=";

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
