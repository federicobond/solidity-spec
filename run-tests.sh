#!/bin/sh

RED="$(tput bold)$(tput setab 1)"
GREEN="$(tput bold)$(tput setab 2)$(tput setaf 0)"
RESET="$(tput sgr0)"

PARSER="../solidity-parser/cli.js"
#PARSER="../solidity2/build/solc/solc"

passes=0
fails=0

pass () {
  echo "$GREEN PASS $RESET $1"
  passes=$((passes+1))
}

fail () {
  echo "$RED FAIL $RESET $1"
  fails=$((fails+1))
}

assert_pass () {
  $PARSER $1 > results/$1 2>&1
  if [ $? -eq 0 ]; then
    pass $1
  else
    fail $1
  fi
}

assert_fail () {
  $PARSER $1 > results/$1 2>&1
  if [ $? -ne 0 ]; then
    pass $1
  else
    fail $1
  fi
}

main () {
  mkdir -p results/{passes,fails}

  for test in passes/*.sol; do
    assert_pass "$test"
  done

  for test in fails/*.sol; do
    assert_fail "$test"
  done

  printf "\n%s tests passed, %s tests failed.\n" $passes $fails
  
  if [ $fails -gt 0 ]; then
    exit 1
  fi
}

main
