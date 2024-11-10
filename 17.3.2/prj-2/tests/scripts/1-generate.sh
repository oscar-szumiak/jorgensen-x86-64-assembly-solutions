#!/usr/bin/env sh

FILE_DIR="$1"

# Useful link:
# https://superuser.com/questions/692175/how-to-create-a-random-txthuman-readable-text-like-ascii-file-in-linux

# LINE_SIZE_LIMIT=1024
# READ_SIZE_LIMIT=2048


#################
# Abbreviations #
#################

# NL - no newlines
# WL - with newlines
# LL - lines less than LINE_SIZE_LIMIT
# LE - lines equal to LINE_SIZE_LIMIT
# LG - lines greater than LINE_SIZE_LIMIT
# SL - size less than READ_SIZE_LIMIT
# SE - size equal to READ_SIZE_LIMIT
# SG - size greater than READ_SIZE_LIMIT


###############
# No newlines #
###############

# Both should fail

tr -dc '[:alnum:]' </dev/urandom | head -c 1000 > "$FILE_DIR/NL_SL"
tr -dc '[:alnum:]' </dev/urandom | head -c 200000 > "$FILE_DIR/NL_SG"


#################
# With newlines #
#################

# ( Lines < LINE_SIZE_LIMIT ) && ( File < READ_SIZE_LIMIT )

# Should succeed

OUTPUT_FILE="$FILE_DIR/WL_LL_SL"

true > "$OUTPUT_FILE"

for _ in $(seq 0 3); do
    tr -dc '[:alnum:]' </dev/urandom | head -c 500 >> "$OUTPUT_FILE"
    printf "\n" >> "$OUTPUT_FILE"
done

# ( Lines = LINE_SIZE_LIMIT ) && ( File > READ_SIZE_LIMIT )

# Should succeed

OUTPUT_FILE="$FILE_DIR/WL_LE_SG"

true > "$OUTPUT_FILE"

for _ in $(seq 0 100); do
    tr -dc '[:alnum:]' </dev/urandom | head -c 1023 >> "$OUTPUT_FILE"
    printf "\n" >> "$OUTPUT_FILE"
done

# ( Lines > LINE_SIZE_LIMIT ) && ( File > READ_SIZE_LIMIT )

# Should fail

OUTPUT_FILE="$FILE_DIR/WL_LG_SG"

true > "$OUTPUT_FILE"

for _ in $(seq 0 3); do
    tr -dc '[:alnum:]' </dev/urandom | head -c 5000 >> "$OUTPUT_FILE"
    printf "\n" >> "$OUTPUT_FILE"
done

