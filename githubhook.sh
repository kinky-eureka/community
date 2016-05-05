#!/bin/sh
at now <<END
  cd "$PWD"
  lib/lazuli/lapis term
    git pull origin deploy --recurse-submodule
  git checkout deploy
  git submodule update
  lib/lazuli/mk production
  lib/lazuli/lapis server production
END
