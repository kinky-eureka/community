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
    if which coffee >/dev/null 2>&1
      then for i in $(find . -name "*.coffee")
        do coffee -sc < $i > $i.js
      done
    fi
    lib/lazuli/lapis server production
  } > githubhook.at.log 2>&1
END
