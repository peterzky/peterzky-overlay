final: prev:
{

  leftwm-git = prev.callPackage ../pkgs/leftwm-git.nix { };

  # files
  mycnip =
    prev.writeText "cnip.txt" (builtins.readFile ../files/cnip.txt);

  labelimg-git = prev.labelImg.overrideAttrs (
    oldAttrs: rec {
      version = "git";
      src = prev.fetchFromGitHub {
        owner = "peterzky";
        repo = "labelImg";
        rev = "b44448acbb8b88a45e809918cea59e62d63d5eab";
        sha256 = "07inxdyrhrg4c5dfa0q78vxh652q32jm66h1y90lnq6cj0567gv8";
        # date = 2021-10-04T14:26:57+08:00;
      };
    }
  );


  # fcitx5 = prev.fcitx5.overrideAttrs (
  #   oldAttrs: rec {
  #     version = "5.0.8";
  #     src = prev.fetchFromGitHub {
  #       owner = "fcitx";
  #       repo = "fcitx5";
  #       rev = "5.0.8";
  #       sha256 = "0czj2awvgk9apdh9rj3vcb04g8x2wp1d4sshvch31nwpqs10hssr";
  #     };
  #   }
  # );

  # packages
  # wayst-git = prev.wayst.overrideAttrs (
  #   oldAttrs: rec {
  #     version = "2021-06-16";
  #     src = prev.fetchFromGitHub {
  #       owner = "91861";
  #       repo = "wayst";
  #       rev = "b3722bb60828d443c07667b01031af68769db9df";
  #       # date = 2021-06-16T19:42:38+02:00;
  #       sha256 = "0jv5jmikivsm7ark9sxf16dhm61vy17vqip0w3c9dcbn6ysbhjml";
  #     };
  #   }
  # );

  nvd = prev.callPackage ../pkgs/nvd { };

  interception-tools-plugins = prev.interception-tools-plugins // {
    space2meta = prev.callPackage ../pkgs/space2meta { };
  };


  v2ray = prev.callPackage ../pkgs/go/v2ray { };

  # gfw-white-list = prev.callPackage ../pkgs/gfw-white-list {};

  san-francisco-font = prev.callPackage ../pkgs/san-francisco-font.nix { };

  sdcv-dict = prev.callPackage ../pkgs/sdcv-dict.nix { };

  # Suckless Tools
  # st = prev.st.overrideAttrs (
  #   oldAttrs: rec {
  #     src = prev.fetchgit {
  #       url = "https://github.com/peterzky/st.git";
  #       rev = "ea6d1e9676c72c15fc664551dcc257b74b189f22";
  #       sha256 = "1g6pxnzkf5c5mlvjax5zbnnf7piq28ar6ywfdcf7k5w8sq1m0vx7";
  #       # date = 2019-07-09T17:53:15+08:00;
  #     };
  #   }
  # );


}
