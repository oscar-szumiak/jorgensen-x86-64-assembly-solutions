#!/usr/bin/env sh

INPUT_DIR="$1"
OUTPUT_DIR="$2"

for file in "$INPUT_DIR"/*; do
    if cmp -s "$file" "$OUTPUT_DIR/$(basename "$file")"; then
        printf "%s are identical\n" "$(basename "$file")";
    else
        printf "%s differ\n" "$(basename "$file")";
    fi
done

