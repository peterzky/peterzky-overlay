{
  description = "Python Virtual Env";

  inputs =
    {
      nixpkgs = {
        url = "nixpkgs";
      };

      flake-utils.url = "github:numtide/flake-utils";

    };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        in
        rec
        {
          packages.default = null;
          devShells.default = pkgs.mkShell rec {
            name = "pipzone";
            venvDir = "./venv";
            buildInputs = with pkgs; [
              python38Packages.python
              python38Packages.venvShellHook
              # qt deps
              glib
              libglvnd
              libxkbcommon
              fontconfig
              freetype
              dbus
              xorg.libX11
              wayland-scanner
              # numpy deps
              zlib
              # pytorch
              cudaPackages.cudatoolkit

            ];

          };

        }
      );
}
  


