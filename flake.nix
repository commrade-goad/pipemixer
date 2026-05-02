{
    description = "TUI volume control app for pipewire by heather7282.";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
                {
                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "pipemixer";
                    version = "0.4.3";
                    src = self;

                    nativeBuildInputs = with pkgs; [
                        meson
                        ninja
                        pkg-config
                    ];

                    buildInputs = with pkgs; [
                        pipewire
                        ncurses
                    ];

                    meta = {
                        description = "TUI volume control app for pipewire.";
                        homepage = "https://github.com/commrade-goad/pipemixer";
                    };
                };

                devShells.default = pkgs.mkShell {
                    buildInputs = with pkgs; [
                        meson
                        ninja
                        pkg-config
                        gcc

                        pipewire
                        ncurses
                        libnotify
                        glibc
                    ];

                    shellHook = ''
                        echo "Use 'meson setup build' to configure your project"
                        echo "Then 'ninja -C build' to build"
                    '';
                };
            });
}
