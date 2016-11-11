#!/bin/bash

RED="$(tput bold)$(tput setab 1)"
GREEN="$(tput bold)$(tput setab 2)$(tput setaf 0)"
RESET="$(tput sgr0)"

PARSER="solc"

PASSES=0
FAILS=0

die () {
  >&2 echo "error: $1"
  exit 1
}

pass () {
  echo "$GREEN PASS $RESET $1"
  PASSES=$((PASSES + 1))
}

fail () {
  echo "$RED FAIL $RESET $1"
  FAILS=$((FAILS + 1))
}

assert_pass () {
  $PARSER "$1" > "output/$1" 2>&1
  if [ $? -eq 0 ]; then
    pass "$1"
  else
    fail "$1"
  fi
}

assert_fail () {
  $PARSER "$1" > "output/$1" 2>&1
  if [ $? -ne 0 ]; then
    pass "$1"
  else
    fail "$1"
  fi
}

filter_file () {
  if [ -z "$FILTER" ]; then
    return 0
  fi

  [[ "$1" == $FILTER ]]
}

test_init () {
  if [ ! -f "$PARSER" ]; then
    die "could not find parser: $PARSER"
  fi

  mkdir -p output/{passes,fails}
}

test_execute () {
  for test in passes/*.sol; do
    if filter_file "$test"; then
      assert_pass "$test"
    fi
  done

  for test in fails/*.sol; do
    if filter_file "$test"; then
      assert_fail "$test"
    fi 
  done
}

test_finalize () {
  printf "\n%s tests passed, %s tests failed.\n" "$PASSES" "$FAILS"
}

usage () {
  echo "usage: ./run_tests.sh [-p <parser>] [-f <glob>]"
  exit
}

while getopts f:p:h opt; do
  case $opt in
    p) PARSER=$OPTARG;;
    f) FILTER=$OPTARG;;
    h) usage;;
   \?) exit 64;;
  esac
done

test_init
test_execute
test_finalize

[ $FAILS -gt 0 ] && exit 1 || exit 0
