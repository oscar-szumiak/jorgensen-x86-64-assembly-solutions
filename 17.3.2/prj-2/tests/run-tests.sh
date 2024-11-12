#!/usr/bin/env sh

#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

# Run tests on program

SCRIPT_DIR="./scripts"

mkdir -p "input"
mkdir -p "output"

"$SCRIPT_DIR/1-generate.sh" "input"
"$SCRIPT_DIR/2-test.sh" "../main.out" "input" "output"
"$SCRIPT_DIR/3-compare.sh" "input" "output"

