{ stdenv, fetchFromGitHub, glibc }:

stdenv.mkDerivation rec {
  pname = "udp2raw";
  version = "git";
  src = fetchFromGitHub {
    owner = "wangyu-";
    repo = "udp2raw";
    rev = "165cabb5a3bae9d561e89e577ccd9cf7c125d68f";
    # date = 2022-01-26T01:00:09-05:00;
    sha256 = "1sxc72jkvwgp1lr7xflnj18984s0s3wmhjr6g1bdz0cxmahpbj0l";
  };
  # buildInputs = [ glibc ];
}
