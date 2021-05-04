final: prev:
{
  fcitx5 = prev.fcitx5.overrideAttrs (
    oldAttrs: rec {
      name = "fcitx5-${version}";
      version = "5.0.7";
      src = prev.fetchFromGitHub {
        owner = "fcitx";
        repo = "fcitx5";
        rev = "5.0.7";
        sha256 = "0wsykm97a7ccxlv108l5m495b0z22wqkpp9hz06c6drxkfgy4mjf";
      };
    }
  );

  fcitx5-gtk = prev.fcitx5-gtk.overrideAttrs (
    oldAttrs: rec {
      name = "fcitx5-gtk-${version}";
      version = "5.0.6";
      rev = "5.0.6";
      sha256 = "0ida7dl67w8ymk7iwyxshkbpbc0f056c5r3wb0paxd0pgmdf0shq";
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
      version = "5.0.5";
      rev = "5.0.5";
      sha256 = "0mcw94a7g8q0qw52i0r645krw5ngb3jn3gmrax9cipnjkkw9488g";
    }
  );
}
