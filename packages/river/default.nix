{ fetchFromGitHub, stdenv, pkgconfig, zig, wayland, wayland-protocols, wlroots
, libxkbcommon, libudev, libevdev, xorg, pixman, libGL }:

stdenv.mkDerivation rec {
  name = "river";
  src = fetchFromGitHub {
    owner = "ifreund";
    repo = "river";
    fetchSubmodules = true;
    rev = "cbd4a2807bcfa74cc87c36d7ec20cdf92a7c77fc";
    # date = 2020-11-18T15:28:33+01:00;
    sha256 = "1bv62zmlzcwr2xfd8f6nhxszsfn1cvb73ndldiminw46c15dz710";
  };

  buildInputs = [
    zig
    wayland
    wayland-protocols
    wlroots
    libxkbcommon
    libudev
    libevdev
    xorg.libX11
    pixman
    libGL
  ];

  nativeBuildInputs = [ pkgconfig ];

  buildPhase = ''
    export HOME=$TMPDIR
    zig build -Drelease-safe=true
  '';

  installPhase = ''
    zig build -Drelease-safe=true --prefix $out install
  '';
}
