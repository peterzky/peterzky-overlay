{ lib, stdenv, fetchFromGitHub, openssl }:
let
  repo_info = lib.importJSON ./version.json;
in
stdenv.mkDerivation rec {
  pname = "smartdns";
  version = lib.substring 0 5 repo_info.rev;

  src = fetchFromGitHub {
    inherit (repo_info) owner repo rev sha256;
  };

  buildInputs = [ openssl ];

  # Force the systemd service file to be regenerated from it's template.  This
  # file is erroneously added in version 35 and it has already been deleted from
  # upstream's git repository.  So this "postPatch" phase can be deleted in next
  # release.
  postPatch = ''
    rm -f systemd/smartdns.service
  '';

  makeFlags = [
    "PREFIX=${placeholder "out"}"
    "SYSTEMDSYSTEMUNITDIR=${placeholder "out"}/lib/systemd/system"
    "RUNSTATEDIR=/run"
  ];

  installFlags = [ "SYSCONFDIR=${placeholder "out"}/etc" ];

  meta = with lib; {
    description =
      "A local DNS server to obtain the fastest website IP for the best Internet experience";
    longDescription = ''
      SmartDNS is a local DNS server. SmartDNS accepts DNS query requests from local clients, obtains DNS query results from multiple upstream DNS servers, and returns the fastest access results to clients.
      Avoiding DNS pollution and improving network access speed, supports high-performance ad filtering.
      Unlike dnsmasq's all-servers, smartdns returns the fastest access resolution.
    '';
    homepage = "https://github.com/pymumu/smartdns";
    maintainers = [ maintainers.lexuge ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
