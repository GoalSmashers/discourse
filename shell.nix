{ pkgs ? import <nixpkgs> {} }:
  with pkgs;
  stdenv.mkDerivation {
    name = "discourse";
    buildInputs = with pkgs; [
      imagemagick
      libmsgpack
      libxml2
      libxslt
      libpqxx
      libsass
      mailcatcher
      nodejs
      postgresql
      ruby
      zlib
    ];
    shellHook = ''
      if ! [ -x "$(command -v bundle)" ]; then
        gem install bundler
      fi

      if [ ! -d "node_modules" ]; then
        npm install
      fi

      if [ ! -d "vendor" ]; then
        bundle install
      fi

      export DISCOURSE_DEV_HOSTS=community.spica.atomicgurus.local
    '';
  }
