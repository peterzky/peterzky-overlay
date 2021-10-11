{ python3Packages, fetchFromGitHub, lib }:
with python3Packages;
buildPythonApplication rec {
  pname = "notify-send.py";
  version = lib.substring 0 5 src.rev;

  src = fetchFromGitHub {
    owner = "phuhl";
    repo = "notify-send.py";
    rev = "0575c79f10d10892c41559dd3695346d16a8b184";
    # date = 2021-05-12T13:32:07+02:00;
    sha256 = "09m15h1yja5x2ihrp92ab3q220mgdcb0k4ld00dccn4krzcn3a7v";
  };

  propagatedBuildInputs = [ dbus-python pygobject3 ];
  patchPhase = ''
    cat << EOF > setup.py
    from setuptools import setup, find_packages
    setup(
        name="notify-send.py",
        version="${src.rev}",
        packages=find_packages(),
        entry_points={
            "console_scripts": [ "notify-send.py=notify_send_py.notify_send_py:main" ]
        }
    )
    EOF
  '';

  doCheck = false;



}
