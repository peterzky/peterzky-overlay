final: prev:
{
  fcitx5 = prev.fcitx5.overrideAttrs (
    oldAttrs: rec {
      name = "fcitx5-${version}";
      version = "5.0.8";
      src = prev.fetchFromGitHub {
        owner = "fcitx";
        repo = "fcitx5";
        rev = "5.0.8";
        sha256 = "0czj2awvgk9apdh9rj3vcb04g8x2wp1d4sshvch31nwpqs10hssr";
      };
    }
  );

  fcitx5-gtk = prev.fcitx5-gtk.overrideAttrs (
    oldAttrs: rec {
      name = "fcitx5-gtk-${version}";
      version = "5.0.7";
      rev = "5.0.7";
      sha256 = "0vcikqrxv1xxcdaiz3axgm7rpab4w8aciw838sbpa9l20dp8cnyq";
    }
  );

  # fcitx5-qt = prev.fcitx5-qt.overrideAttrs (
  #   oldAttrs: rec {
  #     name = "fcitx5-qt-${version}";
  #     version = "1.2.6";
  #     rev = "1.2.6";
  #     sha256 = "13sanrir696fv7s44b7q453s5qi4r7ag0r3iyggyzk8xyf6rw8fk";
  #   }
  # );

  fcitx5-rime = prev.fcitx5-rime.overrideAttrs (
    oldAttrs: rec {
      name = "fcitx5-rime-${version}";
      version = "5.0.6";
      rev = "5.0.6";
      sha256 = "1r36c1pl63vka9mxa8f5x0kijapjgxzz5b4db8h87ri9kcxk7i2g";
    }
  );
}
