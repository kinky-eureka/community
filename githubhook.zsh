#!/bin/zsh
at now <<END
  unset LUA_PATH
  unset LUA_CPATH
  unset MOON_PATH
  cd "$PWD"
  {
    lib/lazuli/lapis term
    git pull origin deploy --recurse-submodule
    git checkout deploy
    git submodule update
    lib/lazuli/mk production
    lib/lazuli/lapis server production
  } > githubhook.at.log 2>&1
END
