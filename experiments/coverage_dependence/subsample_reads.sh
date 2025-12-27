#!/usr/bin/env bash

set -euo pipefail

if [ $# -ne 3 ]; then
    echo "Usage: $0 <input.fastq> <fraction> <output.fastq>"
    echo "Example: $0 reads.fq 0.5 subsampled.fq"
    exit 1
fi

IN="$1"
FRAC="$2"
OUT="$3"

# Count total lines and reads
TOTAL_LINES=$(wc -l < "$IN")
TOTAL_READS=$((TOTAL_LINES / 4))

# Compute target number of reads (floor)
TARGET_READS=$(awk -v n="$TOTAL_READS" -v f="$FRAC" 'BEGIN { printf "%d\n", n*f }')

if [ "$TARGET_READS" -le 0 ]; then
    echo "Target reads is zero — check fraction."
    exit 1
fi

# Generate random read indices (1-based)
shuf -i 1-"$TOTAL_READS" -n "$TARGET_READS" | sort -n > /tmp/keep_reads.$$

# Extract reads
awk '
  NR==FNR { keep[$1+0]=1; next }
  {
    read_id = int((FNR-1)/4) + 1
    if (keep[read_id]) print
  }
' /tmp/keep_reads.$$ "$IN" > "$OUT"

rm /tmp/keep_reads.$$

echo "Wrote $TARGET_READS reads to $OUT"