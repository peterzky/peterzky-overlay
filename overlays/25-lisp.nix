self: super: {
  lispPackages = super.lispPackages // {
    nyxt = super.lispPackages.nyxt.overrideAttrs (oldAttrs: rec {
      meta.version = "2-pre-release-6";
      src = super.fetchFromGitHub {
        owner = "atlas-engineer";
        repo = "nyxt";
        rev = "2-pre-release-6";
        sha256 = "0kcqp3p070i6x2jj27h8pxzvmhrzsl4kl3vkc8m76abkxc9lvn03";
      };
    });
  };

}
