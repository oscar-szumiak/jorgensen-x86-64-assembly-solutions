#!/usr/bin/env sh

#
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2024 Oscar Szumiak
#

# Compare files from $INPUT_DIR and $OUTPUT_DIR

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for file in "$INPUT_DIR"/*; do
    if cmp -s "$file" "$OUTPUT_DIR/$(basename "$file")"; then
        printf "%s are identical\n" "$(basename "$file")";
    else
        printf "%s differ\n" "$(basename "$file")";
    fi
done

