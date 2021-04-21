self: super: {
  lispPackages = super.lispPackages // {
    nyxt = super.lispPackages.nyxt.overrideAttrs (oldAttrs: rec {
      src = super.fetchFromGitHub {
        owner = "atlas-engineer";
        repo = "nyxt";
        rev = "df34d8297505194831e1d09d4df5bd556eeaa0d0";
        # date = 2021-04-21T15:44:13+02:00;
        sha256 = "04r10alhsgs5iw7iw769rky4lyhi2igr8mivgah2wm0lja62x92v";
      };
    });
  };

}
