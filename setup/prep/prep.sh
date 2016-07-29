#!/bin/bash
# prep.sh
# aoneill - 07/26/16

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function init() {
  for file in $(find "$DIR" -maxdepth 1 -type f -name "*-*" | sort); do
    [[ -x "$file" ]] && "$file"
  done
}

function sourced() {
  SETUP="$(cd "$DIR/../" && pwd)"
  source "$SETUP/common/util/util.sh"
  
  passed="$1"
  function gate() {
    if [[ "$passed" == "all" ]]; then
      cat -
    else
      cat - | grep -v "$passed\$"
    fi
  }

  if [[ "$passed" != "" ]]; then
    for file in $(find "$DIR" -maxdepth 1 -type f -name "*-*" | gate | sort); do
      [[ -x "$file" ]] && source "$file"
    done
  fi
}

# Run init only when run
EXEC=$(test "${BASH_SOURCE[0]}" != "${0}"; echo $?)
[[ "$EXEC" == "1" ]] && init $@
[[ "$EXEC" == "0" ]] && sourced $@
