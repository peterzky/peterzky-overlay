{ fetchgit, python3Packages, libmaxminddb }:

with python3Packages;

let
  urwidtrees_dev = buildPythonPackage rec {
    name = "urwidtrees-${rev}";
    rev = "207563ad5d750155104ed25292a264957f79af51";

    src = fetchgit {
      url = "https://github.com/pazz/urwidtrees.git";
      inherit rev;
      sha256 = "0rvhi0bcpa9fvfxcj7az7928db9n8bf9phh9nq1hizldzz3vkdkj";
    };

    propagatedBuildInputs = [ urwid mock ];

  };

  maxminddb = buildPythonPackage rec {
    pname = "maxminddb";
    version = "1.4.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1swi0zd86xpfpf55x79vhn5difw0yj27cn581z4nxmx4niqvq42w";
    };

    propagatedBuildInputs = [ cython libmaxminddb ];

    doCheck = false;
  };

in buildPythonPackage rec {
  pname = "stig";
  version = "0.9.0a0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0kd5v50r3p4df46s713m6dd3qww9nc1ng7457k12q7a6afvhl8k3";
  };

  doCheck = false;

  propagatedBuildInputs = [
    blinker
    pyxdg
    aiohttp
    natsort
    urwid
    urwidtrees_dev
    maxminddb
    setproctitle
  ];

  meta = {
    homepage = "https://github.com/rndusr/stig";
    description =
      "stig is a TUI (text user interface) and CLI (command line interface) client for the BitTorrent client Transmission.";
  };
}
