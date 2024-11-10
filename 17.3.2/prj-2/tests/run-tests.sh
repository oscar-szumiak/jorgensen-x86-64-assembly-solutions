#!/usr/bin/env sh

SCRIPT_DIR="./scripts"

mkdir "input"
mkdir "output"

"$SCRIPT_DIR/1-generate.sh" "input"
"$SCRIPT_DIR/2-test.sh" "../main.out" "input" "output"
"$SCRIPT_DIR/3-compare.sh" "input" "output"

