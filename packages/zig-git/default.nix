{ stdenv, lib, fetchFromGitHub, cmake, llvmPackages, libxml2, zlib
, substituteAll }:

llvmPackages.stdenv.mkDerivation rec {
  version = "0.7.0";
  pname = "zig";

  src = fetchFromGitHub {
    owner = "ziglang";
    repo = pname;
    rev = version;
    sha256 = "0gq8xjqr3n38i2adkv9vf936frac80wh72dvhh4m5s66yafmhphg";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    llvmPackages.clang-unwrapped
    llvmPackages.llvm
    llvmPackages.lld
    libxml2
    zlib
  ];

  preBuild = ''
    export HOME=$TMPDIR;
  '';

  # checkPhase = ''
  #   runHook preCheck
  #   ./zig test $src/test/stage1/behavior.zig
  #   runHook postCheck
  # '';

  doCheck = false;

  meta = with lib; {
    description =
      "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software";
    homepage = "https://ziglang.org/";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [ maintainers.andrewrk ];
    # See https://github.com/NixOS/nixpkgs/issues/86299
    broken = stdenv.isDarwin;
  };
}
