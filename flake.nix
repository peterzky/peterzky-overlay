{
  description = "Peter's personal overlay";

  outputs = { self }: {
    overlay = final: prev: import ./default.nix final prev;

  };
}
