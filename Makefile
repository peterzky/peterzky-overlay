
.PHONY: update update-flake

update-flake:
	nix flake update

update: update-flake
	nix run .#flake-updater -- .
