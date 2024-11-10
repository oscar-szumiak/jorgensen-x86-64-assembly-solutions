#!/usr/bin/env sh

PROGRAM="$1"
INPUT_DIR="$2"
OUTPUT_DIR="$3"

for file in "$INPUT_DIR"/*; do
    "$PROGRAM" "$file" > "$OUTPUT_DIR/$(basename "$file")"
done

