#!/bin/sh -e

INPUT=$1
OUTPUT=$2

cat "$INPUT" \
    | sed '/__fsid_t/d' \
    | grep -v "^#" \
    | sed -e 's/_Bool/_Bool\n/' \
    | sed -e 's/\r//g' \
    > "$OUTPUT"
