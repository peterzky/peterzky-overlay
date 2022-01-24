{ lib, fetchFromGitHub, rustPlatform, libX11, libXinerama }:

let
  rpathLibs = [ libXinerama libX11 ];
in

rustPlatform.buildRustPackage rec {
  pname = "leftwm";
  version = builtins.substring 0 6 src.rev;

  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
  };

  # cargoHash = "sha256-gFiKtIDIyvMWK0GuFd6guvGa+a23zcqafEuzdljqk+k=";
  cargoHash = lib.fakeHash;
  # update correct hash above

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
