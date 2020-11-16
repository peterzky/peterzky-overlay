{ symlinkJoin, fcitx5,  makeWrapper,  fcitx5-qt, fcitx5-rime, fcitx5-kcm }:

symlinkJoin {
  name = "fcitx5-with-plugins";

  paths = [ fcitx5 fcitx5-qt fcitx5-rime fcitx5-kcm ];

  buildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/fcitx5 \
      --set FCITXDIR "$out/"
  '';
}
