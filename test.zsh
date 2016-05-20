#!/bin/zsh

cd "$(dirname "$(readlink -f "$0")")"

sigint_handler()
{
  lib/lazuli/lapis term
  kill $PID
  exit
}

trap sigint_handler SIGINT

while true; do
  lib/lazuli/mk development
  if which coffee >/dev/null 2>&1
    then for i in $(find . -name "*.coffee")
      do coffee -sc < $i > $i.js
    done
  fi
  lib/lazuli/lapis server development &
  PID=$!
  until inotifywait -e modify -e moved_to -e create -e delete -r . | grep -e '.moon' -e '.coffee' -e '.less'
    do :
  done
  lib/lazuli/lapis term
  kill $PID
done
