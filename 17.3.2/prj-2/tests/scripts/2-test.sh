#!/usr/bin/env sh

#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

# Run $PROGRAM on test files from $INPUT_DIR and save output into $OUTPUT_DIR

PROGRAM="$1"
INPUT_DIR="$2"
OUTPUT_DIR="$3"

for file in "$INPUT_DIR"/*; do
    "$PROGRAM" "$file" > "$OUTPUT_DIR/$(basename "$file")"
done

